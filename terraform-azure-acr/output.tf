output "id" {
  description = "Specifies the resource id of the container registry"
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Specifies the name of the container registry"
  value       = azurerm_container_registry.this.name
}

output "rg_name" {
  description = "Specifies the resource group name of the container registry"
  value       = azurerm_container_registry.this.resource_group_name
}

output "login_server" {
  description = "Specifies the login server of the container registry"
  value       = azurerm_container_registry.this.login_server
}

output "login_server_url" {
  description = "Specifies the login server url of the container registry"
  value       = "https://${azurerm_container_registry.this.login_server}"
}

output "acr" {
  description = "azurerm_container_registry resource"
  value       = azurerm_container_registry.this
  sensitive   = true
}
