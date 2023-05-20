/* Create iothub_dps Resource */
resource "azurerm_iothub_dps" "this" {
  name                = "${var.name_prefix}-dps-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_policy   = var.allocation_policy

  dynamic "ip_filter_rule" {
    for_each = (var.ip_filter_rule_ip_mask != null && var.pubnet_access_enabled == true) ? toset([1]) : toset([])

    content {
      name    = "${var.name_prefix}-dpsiprule-${var.descriptor}"
      ip_mask = var.ip_filter_rule_ip_mask
      action  = var.ip_filter_rule_action
    }
  }

  sku {
    name     = "S1"
    capacity = "1"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [linked_hub,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

/* Add iothub_dps device root certificate */
resource "azurerm_iothub_dps_certificate" "this" {
  name                = "dpsrootcertificateRootCA"
  resource_group_name = var.resource_group_name
  iot_dps_name        = azurerm_iothub_dps.this.name
  certificate_content = var.device_root_cert
  is_verified         = true
}

/* Add iothub_dps private_endpoint */
resource "azurerm_private_endpoint" "this" {
  count                         = (var.pvtnet_access_enabled == true) ? 1 : 0
  name                          = "${var.name_prefix}-pe-dps-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-dps-${var.descriptor}"
  private_service_connection {
    name                           = "${var.name_prefix}-pl-dps-${var.descriptor}"
    private_connection_resource_id = azurerm_iothub_dps.this.id
    is_manual_connection           = false
    subresource_names              = ["iotDps"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

## diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_iothub_dps.this.name, "diag"))
  target_resource_id         = azurerm_iothub_dps.this.id
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
