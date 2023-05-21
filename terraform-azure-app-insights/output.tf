output "id" {
  value       = azurerm_application_insights.this.id
  description = "ID of the application insights instance"
}

output "name" {
  value       = azurerm_application_insights.this.name
  description = "Name of the application insights instance"
}

output "rg_name" {
  value       = azurerm_application_insights.this.resource_group_name
  description = "Resource group name of the application insights instance"
}

output "instrumentation_key" {
  description = "Value of the instrumentation key"
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "Connection string for the Application Insights instance"
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}

output "app_id" {
  value       = azurerm_application_insights.this.app_id
  description = "value of the app id"
}
