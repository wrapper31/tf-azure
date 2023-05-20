output "linux_function_app_id" {
  description = "linux_function_app ID- output to oher module subsystems"
  value       = azurerm_linux_function_app.this.id
}

output "linux_function_app_name" {
  description = "linux_function_app Name-output to oher module subsystems"
  value       = azurerm_linux_function_app.this.name
}

output "linux_function_app_rg_name" {
  description = "linux_function_app resource group name- output to oher module subsystems"
  value       = azurerm_linux_function_app.this.resource_group_name
}
