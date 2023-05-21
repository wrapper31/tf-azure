output "resource_group_name" {
  description = "resource group name- output to oher module subsystems"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "resource_group ID- output to oher module subsystems"
  value       = azurerm_resource_group.rg.id
}

output "service_plan_id" {
  description = " ID- output to oher module subsystems"
  value       = azurerm_service_plan.tf_ucp.id
}

output "service_plan_name" {
  description = "Service plan name- output to oher module subsystems"
  value       = azurerm_service_plan.tf_ucp.name
}

output "service_plan_rg_name" {
  description = "Service plan resource group name- output to oher module subsystems"
  value       = azurerm_service_plan.tf_ucp.resource_group_name
}

output "storage_account_name" {
  description = "Storage account name- output to oher module subsystems"
  value       = azapi_resource.storage_account.name
}

output "key_vault_id" {
  description = "key_vault ID- output to oher module subsystems"
  value       = module.key_vault.key_vault_id
}

output "key_vault_identity_id" {
  description = "key_vault_identity ID- output to oher module subsystems"
  value       = module.key_vault.identity_id
}
