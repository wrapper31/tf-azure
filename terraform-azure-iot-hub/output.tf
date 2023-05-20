output "name" {
  description = "IotHub Name- output to oher module subsystems"
  value       = azurerm_iothub.this.name
}

output "id" {
  description = "IotHub ID- output to oher module subsystems"
  value       = azurerm_iothub.this.id
}

output "resource_group_name" {
  description = "IotHub resource group name- output to oher module subsystems"
  value       = azurerm_iothub.this.resource_group_name
}
