locals {
  event_hub = { for eh in var.event_hub : eh.name => eh }
}

resource "azurerm_eventhub_namespace" "this" {
  name                          = "${var.resource_prefix}-evhns-${var.descriptor}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  tags                          = var.tags
  capacity                      = var.capacity
  auto_inflate_enabled          = var.auto_inflate != null ? var.auto_inflate.enabled : null
  maximum_throughput_units      = var.auto_inflate != null ? var.auto_inflate.maximum_throughput_units : null
  zone_redundant                = true
  public_network_access_enabled = var.allow_all_public_networks || var.is_public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  minimum_tls_version           = var.minimum_tls_version

  network_rulesets = var.allow_all_public_networks ? null : [
    {
      default_action                 = "Deny"
      public_network_access_enabled  = var.is_public_network_access_enabled
      virtual_network_rule           = null
      trusted_service_access_enabled = true
      ip_rule = [
        {
          ip_mask = "198.208.0.0/16"
          action  = "Allow"
        }
      ]
    }
  ]
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_eventhub" "this" {
  for_each = local.event_hub

  name                = each.key
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  partition_count     = each.value.partitions
  message_retention   = each.value.message_retention
}

resource "azurerm_eventhub_authorization_rule" "this" {
  for_each = local.event_hub

  name                = each.value.authorization.name
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  eventhub_name       = each.key
  listen              = each.value.authorization.listen
  send                = each.value.authorization.send
  manage              = each.value.authorization.manage

  depends_on = [azurerm_eventhub.this]
}

resource "azurerm_private_endpoint" "this" {
  name                          = "${var.resource_prefix}-pe-evhns-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.resource_prefix}-nic-evhns-${var.descriptor}"
  private_service_connection {
    name                           = "${var.resource_prefix}-pl-evhns-${var.descriptor}"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
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

## diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_eventhub_namespace.this.name, "diag"))
  target_resource_id         = azurerm_eventhub_namespace.this.id
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
