output "adls_id" {
  description = "ADLS ID- output to oher module subsystems"
  value       = azurerm_storage_account.this.id
}

output "adls_name" {
  description = "ADLS Name-output to oher module subsystems"
  value       = azurerm_storage_account.this.name
}

output "adls_rg_name" {
  description = "ADLS resource group name- output to oher module subsystems"
  value       = azurerm_storage_account.this.resource_group_name
}

output "adls_private_endpoint_id" {
  description = "ADLS private endpoint ID- output to oher module subsystems"
  value       = azurerm_private_endpoint.adls_private_endpoint.id
}

output "adls_private_endpoint_name" {
  description = "ADLS private endpoint Name- output to oher module subsystems"
  value       = azurerm_private_endpoint.adls_private_endpoint.name
}
output "adls_private_endpoint_rg_name" {
  description = "ADLS private endpoint Resource group name- output to oher module subsystems"
  value       = azurerm_private_endpoint.adls_private_endpoint.resource_group_name
}
