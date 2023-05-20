resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_dashboard_grafana.this.name, "diag"))
  target_resource_id         = azurerm_dashboard_grafana.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_logs

    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
