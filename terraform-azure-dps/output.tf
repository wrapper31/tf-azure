output "dps_id" {
  description = "DPS ID- output to oher module subsystems"
  value       = azurerm_iothub_dps.this.id
}

output "dps_name" {
  description = "DPS Name-output to oher module subsystems"
  value       = azurerm_iothub_dps.this.name
}

output "dps_rg_name" {
  description = "DPS resource group name- output to oher module subsystems"
  value       = azurerm_iothub_dps.this.resource_group_name
}
