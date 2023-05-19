output "hostname" {
  description = "linux_web_app default hostname- output to other module subsystems"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "linux_web_app_id" {
  description = "linux_web_app ID- output to other module subsystems"
  value       = azurerm_linux_web_app.this.id
}

output "linux_web_app_name" {
  description = "linux_web_app Name-output to other module subsystems"
  value       = azurerm_linux_web_app.this.name
}

output "linux_web_app_rg_name" {
  description = "linux_web_app resource group name- output to other module subsystems"
  value       = azurerm_linux_web_app.this.resource_group_name
}

output "app_Service_cert_id" {
  description = "app_Service_cert ID- output to other module subsystems"
  value       = var.certificate_name != null ? azurerm_app_service_certificate.this[0].id : null
}

output "app_Service_cert_name" {
  description = "app_Service_cert Name-output to other module subsystems"
  value       = var.certificate_name != null ? azurerm_app_service_certificate.this[0].name : null
}

output "app_Service_cert_rg_name" {
  description = "app_Service_cert resource group name- output to other module subsystems"
  value       = var.certificate_name != null ? azurerm_app_service_certificate.this[0].resource_group_name : null
}

output "app_service" {
  description = "azurerm_linux_web_app resource"
  value       = azurerm_linux_web_app.this
}
