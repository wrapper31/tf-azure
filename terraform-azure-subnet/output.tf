output "subnet_id" {
  value       = azapi_resource.subnet.id
  description = "Network Subnet ID"
}

output "subnet_nsg_id" {
  value       = azurerm_network_security_group.this.id
  description = "Network Security group ID"
}

output "subnet_nsg_name" {
  value       = azurerm_network_security_group.this.name
  description = "Network Security group name"
}

output "subnet_nsg_rg_name" {
  value       = azurerm_network_security_group.this.resource_group_name
  description = "Network Security group resource group name"
}

output "route_table_id" {
  description = "route_table ID- output to oher module subsystems"
  value       = azurerm_route_table.this.id
}

output "route_table_name" {
  description = "route_table Name-output to oher module subsystems"
  value       = azurerm_route_table.this.name
}

output "route_table_rg_name" {
  description = "route_table resource group name- output to oher module subsystems"
  value       = azurerm_route_table.this.resource_group_name
}
