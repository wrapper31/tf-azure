output "consumer_group_id" {
  description = "eventhub consumer_group ID- output to oher module subsystems"
  value       = [for cg in azurerm_eventhub_consumer_group.this : cg.id]
}

output "consumer_group_name" {
  description = "eventhub consumer_group name- output to oher module subsystems"
  value       = [for cg in azurerm_eventhub_consumer_group.this : cg.name]
}

output "consumer_group_rg_name" {
  description = "eventhub consumer_group resource group name- output to oher module subsystems"
  value       = [for cg in azurerm_eventhub_consumer_group.this : cg.resource_group_name]
}

output "consumer_group_namespace_name" {
  description = "eventhub consumer_group namespace name- output to oher module subsystems"
  value       = [for cg in azurerm_eventhub_consumer_group.this : cg.namespace_name]
}

output "consumer_group_eventhub_name" {
  description = "eventhub consumer_group eventhub name- output to oher module subsystems"
  value       = [for cg in azurerm_eventhub_consumer_group.this : cg.eventhub_name]
}
