output "hub_to_spoke_peering" {
  description = "The azurerm_virtual_network_peering resource for the hub to spoke peering"
  value       = azurerm_virtual_network_peering.hub_to_spoke
}

output "spoke_to_hub_peering" {
  description = "The azurerm_virtual_network_peering resource for the spoke to hub peering"
  value       = azurerm_virtual_network_peering.spoke_to_hub
}

output "vnet" {
  description = "The azurerm_virtual_network resource for the created spoke VNet"
  value       = azurerm_virtual_network.this
}

output "resource_group" {
  description = "The azurerm_resource_group resource where the rest of the resources are created"
  value       = azurerm_resource_group.this
}

output "dns_zone" {
  description = "The azurerm_private_dns_zone resource for the created private DNS zone"
  value       = azurerm_private_dns_zone.this
}

output "resource_group_name" {
  description = "The name of the resource group with the VNet and peering resources"
  value       = azurerm_virtual_network.this.resource_group_name
}

output "firewall_ip" {
  description = "The IP of the firewall to use with this VNet"
  value       = local.firewall_ip
}

output "virtual_network_name" {
  description = "The name of the created VNet"
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_resource_group_name" {
  description = "The name of the resource group where the VNet is created"
  value       = azurerm_virtual_network.this.resource_group_name
}

output "environment_private_dns_zone_name" {
  description = "The name of the private DNS zone for the environment"
  value       = local.private_dns_zone_name
}

output "environment_private_dns_zone_resource_group" {
  description = "The name of the resource group where the private DNS zone is created"
  value       = azurerm_private_dns_zone.this.resource_group_name
}