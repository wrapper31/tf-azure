output "iot_hub_subnet_id" {
  description = "iot_hub subnet ID- output to iot_hub subsystems"
  value       = module.iot_hub_subnet.subnet_id
}

output "event_hub_subnet_id" {
  description = "event_hub subnet ID- output to event_hub subsystems"
  value       = module.event_hub_subnet.subnet_id
}

output "event_grid_subnet_id" {
  description = "event_grid subnet ID- output to event_grid subsystems"
  value       = module.event_grid_subnet.subnet_id
}

output "function_apps_subnet_id" {
  description = "function_apps subnet ID- output to function_apps subsystems"
  value       = module.function_apps_subnet.subnet_id
}

output "service_bus_subnet_id" {
  description = "service_bus subnet ID- output to service_bus subsystems"
  value       = module.service_bus_subnet.subnet_id
}

output "aks_subnet_id" {
  description = "aks_subnet subnet ID- output to aks_subnet subsystems"
  value       = module.aks_subnet.subnet_id
}

output "dev_portal_subnet_id" {
  description = "dev_portal subnet ID- output to dev_portal subsystems"
  value       = module.dev_portal_subnet.subnet_id
}

output "storage_account_subnet_id" {
  description = "storage_account subnet ID- output to storage_account subsystems"
  value       = module.storage_account_subnet.subnet_id
}

output "key_vault_subnet_id" {
  description = "key_vault subnet ID- output to key_vault subsystems"
  value       = module.key_vault_subnet.subnet_id
}

output "app_service_subnet_id" {
  description = "app_service subnet ID- output to app_service subsystems"
  value       = module.app_service_subnet.subnet_id
}

output "cosmos_db_subnet_id" {
  description = "cosmos_db subnet ID- output to cosmos_db subsystems"
  value       = module.cosmos_db_subnet.subnet_id
}

output "app_gateway_subnet_id" {
  description = "app_gateway subnet ID- output to app_gateway subsystems"
  value       = module.app_gateway_subnet.subnet_id
}
