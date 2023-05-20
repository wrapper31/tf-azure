locals {
  event_hub_name = { for eh in var.event_hub_routes : eh.endpoint.name => eh }
}

resource "azurerm_iothub" "this" {
  name                          = "${var.name_prefix}-iot-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = var.pubnet_access_enabled

  sku {
    name     = var.sku
    capacity = var.units
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_role_assignment" "vsu_eventhub_data_sender_iot" {
  principal_id         = azurerm_iothub.this.identity[0].principal_id
  role_definition_name = "Azure Event Hubs Data Sender"
  scope                = var.eventhub_namespace_vsu_id
}

resource "azurerm_role_assignment" "vsu_eventhub_data_receiver_iot" {
  principal_id         = azurerm_iothub.this.identity[0].principal_id
  role_definition_name = "Azure Event Hubs Data Receiver"
  scope                = var.eventhub_namespace_vsu_id
}

resource "azurerm_iothub_endpoint_eventhub" "this" {
  for_each = local.event_hub_name

  name                = "${each.key}-ep"
  resource_group_name = var.resource_group_name
  authentication_type = "identityBased"
  endpoint_uri        = "sb://${each.value.endpoint.namespace_name}.servicebus.windows.net"
  entity_path         = each.key
  iothub_id           = azurerm_iothub.this.id

  depends_on = [
    azurerm_role_assignment.vsu_eventhub_data_sender_iot,
    azurerm_role_assignment.vsu_eventhub_data_receiver_iot,
    azapi_update_resource.iothub_nw_rule_sets
  ]
}

resource "azurerm_iothub_route" "this" {
  for_each = local.event_hub_name

  name                = "${each.key}-route"
  resource_group_name = var.resource_group_name
  iothub_name         = azurerm_iothub.this.name
  source              = "DeviceMessages"
  condition           = each.value.condition
  endpoint_names      = ["${each.key}-ep"]
  enabled             = true

  depends_on = [
    azurerm_iothub_endpoint_eventhub.this
  ]
}

resource "azurerm_eventgrid_system_topic" "this" {
  name                   = "${var.name_prefix}-evgt-${var.descriptor}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = azurerm_iothub.this.id
  topic_type             = "Microsoft.Devices.IoTHubs"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azapi_update_resource.iothub_nw_rule_sets
  ]
}

resource "azurerm_role_assignment" "eventhub_data_sender" {
  for_each = var.event_grid_subscriptions

  principal_id         = azurerm_eventgrid_system_topic.this.identity[0].principal_id
  role_definition_name = "Azure Event Hubs Data Sender"
  scope                = each.value.event_hub_id
}

resource "azurerm_eventgrid_system_topic_event_subscription" "this" {
  for_each = var.event_grid_subscriptions

  name                 = "${var.name_prefix}-evgs-${var.descriptor}${each.key}"
  system_topic         = azurerm_eventgrid_system_topic.this.name
  resource_group_name  = var.resource_group_name
  eventhub_endpoint_id = each.value.event_hub_id
  included_event_types = each.value.event_types

  delivery_identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_role_assignment.eventhub_data_sender
  ]
}

resource "azurerm_private_endpoint" "this" {
  count = (var.pvtnet_access_enabled == true) ? 1 : 0

  name                          = "${var.name_prefix}-pe-iot-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-iot-${var.descriptor}"
  private_service_connection {
    name                           = "${var.name_prefix}-pl-iot-${var.descriptor}"
    private_connection_resource_id = azurerm_iothub.this.id
    is_manual_connection           = false
    subresource_names              = ["iotHub"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azapi_update_resource" "iothub_nw_rule_sets" {
  count = (var.pubnet_access_enabled == true && var.iprule_ipmask != null) ? 1 : 0

  type        = "Microsoft.Devices/IotHubs@2021-07-02"
  resource_id = azurerm_iothub.this.id

  body = jsonencode({
    properties = {
      networkRuleSets = {
        applyToBuiltInEventHubEndpoint = var.netrule_to_builtin_evnthub_endpt
        defaultAction                  = var.netrule_default_action
        ipRules = [
          {
            action     = var.iprule_action
            filterName = "${var.name_prefix}-iotiprule-${var.descriptor}"
            ipMask     = var.iprule_ipmask
          }
        ]
      }
    }
  })

  depends_on = [
    azurerm_private_endpoint.this
  ]
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics ? 1 : 0
  name                       = lower("iot-${var.name_prefix}-iot-${var.descriptor}-diags")
  target_resource_id         = azurerm_iothub.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_logs

    content {
      category = enabled_log.value.category

      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "eventgrid-diag" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower("evg-${var.name_prefix}-iot-${var.descriptor}-diags")
  target_resource_id         = azurerm_eventgrid_system_topic.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.eventgrid_diagnostic_logs

    content {
      category = enabled_log.value.category

      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.eventgrid_diagnostic_metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
