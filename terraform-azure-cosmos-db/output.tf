output "cosmosdb_acc" {
  description = "cosmosdb_acc- output to oher module subsystems"
  value       = azurerm_cosmosdb_account.this
}

output "cosmosdb_sqldb" {
  description = "cosmosdb_sql database- output to oher module subsystems"
  value       = azurerm_cosmosdb_sql_database.this
}

output "cosmosdb_acc_id" {
  description = "cosmosdb_acc ID- output to oher module subsystems"
  value       = azurerm_cosmosdb_account.this.id
}

output "cosmosdb_acc_name" {
  description = "cosmosdb_acc Name-output to oher module subsystems"
  value       = azurerm_cosmosdb_account.this.name
}

output "cosmosdb_acc_rg_name" {
  description = "cosmosdb_acc resource group name- output to oher module subsystems"
  value       = azurerm_cosmosdb_account.this.resource_group_name
}

output "cosmosdb_sql_id" {
  description = "cosmosdb_sql ID- output to oher module subsystems"
  value       = [for eh in azurerm_cosmosdb_sql_database.this : eh.id]
}

output "cosmosdb_sql_name" {
  description = "cosmosdb_sql Name-output to oher module subsystems"
  value       = [for eh in azurerm_cosmosdb_sql_database.this : eh.name]
}

output "cosmosdb_sql_rg_name" {
  description = "cosmosdb_sql resource group name- output to oher module subsystems"
  value       = [for eh in azurerm_cosmosdb_sql_database.this : eh.resource_group_name]
}

output "cosmosdb_sql_databases" {
  description = "Map of azurerm_cosmosdb_sql_database resources"
  value       = azurerm_cosmosdb_sql_database.this
}

output "cosmosdb_sql_containers" {
  description = "Map of azurerm_cosmosdb_sql_container resources"
  value       = azurerm_cosmosdb_sql_container.this
}
