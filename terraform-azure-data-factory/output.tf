output "adf_id" {
  description = "Azure Data Factory ID"
  value       = azurerm_data_factory.this.id
}

output "adf_name" {
  description = "The name of the newly created Azure Data Factory"
  value       = azurerm_data_factory.this.name
}

output "adf_global_paramaters" {
  description = "A map showing any created ADF Global Parameters."
  value       = { for gp in azurerm_data_factory.this.global_parameter : gp.name => gp }
}
output "shir" {
  description = "ADF Self Hosted Integration Runtime"
  value       = azurerm_data_factory_integration_runtime_self_hosted.this[*]
}
