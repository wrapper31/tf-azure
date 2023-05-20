output "grafana_id" {
  description = "Azure grafana resource id"
  value       = azurerm_dashboard_grafana.this.id
}

output "grafana_url" {
  description = "Azure grafana url"
  value       = azurerm_dashboard_grafana.this.endpoint
}
