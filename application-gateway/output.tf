output "public_ip_prefix_id" {
  description = "public_ip_prefix ID- output to oher module subsystems"
  value       = azurerm_public_ip_prefix.this.id
}

output "public_ip_prefix_name" {
  description = "public_ip_prefix Name-output to oher module subsystems"
  value       = azurerm_public_ip_prefix.this.name
}

output "public_ip_prefix_rg_name" {
  description = "public_ip_prefix resource group name- output to oher module subsystems"
  value       = azurerm_public_ip_prefix.this.resource_group_name
}

output "public_ip_id" {
  description = "public_ip ID- output to oher module subsystems"
  value       = azurerm_public_ip.this.id
}

output "public_ip_name" {
  description = "public_ip Name-output to oher module subsystems"
  value       = azurerm_public_ip.this.name
}

output "public_ip_address" {
  description = "ip Address for Application gateway public IP"
  value       = azurerm_public_ip.this.ip_address
}
output "public_ip_rg_name" {
  description = "public_ip resource group name- output to oher module subsystems"
  value       = azurerm_public_ip.this.resource_group_name
}

output "waf_policy_id" {
  description = "web_application_firewall_policy ID- output to oher module subsystems"
  value       = azurerm_web_application_firewall_policy.this.id
}

output "waf_policy_name" {
  description = "web_application_firewall_policy Name-output to oher module subsystems"
  value       = azurerm_web_application_firewall_policy.this.name
}

output "waf_policy_rg_name" {
  description = "web_application_firewall_policy resource group name- output to oher module subsystems"
  value       = azurerm_web_application_firewall_policy.this.resource_group_name
}

output "appgw_id" {
  description = "app gateway ID- output to oher module subsystems"
  value       = azurerm_application_gateway.this.id
}

output "appgw_name" {
  description = "app gateway Name-output to oher module subsystems"
  value       = azurerm_application_gateway.this.name
}

output "appgw_rg_name" {
  description = "app gateway resource group name- output to oher module subsystems"
  value       = azurerm_application_gateway.this.resource_group_name
}

output "fqdn" {
  description = "The FQDN of the public IP address associated with the Application Gateway"
  value       = azurerm_public_ip.this.fqdn
}

output "public_ip_prefix" {
  description = "azurerm_public_ip_prefix resource"
  value       = azurerm_public_ip_prefix.this
}

output "public_ip" {
  description = "azurerm_public_ip resource"
  value       = azurerm_public_ip.this
}

output "web_application_firewall_policy" {
  description = "azurerm_web_application_firewall_policy resource"
  value       = azurerm_web_application_firewall_policy.this
}

output "application_gateway" {
  description = "azurerm_application_gateway resource"
  value       = azurerm_application_gateway.this
}
