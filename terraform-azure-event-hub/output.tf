output "authorization_rules" {
  description = "Authorization rules for eventhub"
  value       = azurerm_eventhub_authorization_rule.this
  sensitive   = true
}

output "eventhubs" {
  description = "Available eventhubs"
  value       = azurerm_eventhub.this
}

output "eventhub_namespace_id" {
  description = "ID of Event Hub Namespace"
  value       = azurerm_eventhub_namespace.this.id
}

output "eventhub_namespace_name" {
  description = "Name of Event Hub Namespace"
  value       = azurerm_eventhub_namespace.this.name
}

output "eventhub_namespace_rg_name" {
  description = "Resource group Name of Event Hub Namespace"
  value       = azurerm_eventhub_namespace.this.resource_group_name
}

output "eventhub_names" {
  description = "List of event hub names under namespace"
  value       = [for eh in azurerm_eventhub.this : eh.name]
}

output "eventhub_id" {
  description = "eventhub ID- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub.this : eh.id]
}

output "eventhub_rg_name" {
  description = "eventhub resource group name- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub.this : eh.resource_group_name]
}

output "ev_authorization_rule_id" {
  description = "Event hub authorization rule ID- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub_authorization_rule.this : eh.id]
}

output "ev_authorization_rule_name" {
  description = "Event hub authorization rule Name-output to oher module subsystems"
  value       = [for eh in azurerm_eventhub_authorization_rule.this : eh.name]
}

output "ev_authorization_rule_rg_name" {
  description = "Event hub authorization rule resource group name- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub_authorization_rule.this : eh.resource_group_name]
}

output "ev_authorization_rule_evhname" {
  description = "Event hub authorization rule event hub name- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub_authorization_rule.this : eh.eventhub_name]
}

output "ev_authorization_rule_namespacename" {
  description = "Event hub authorization rule eventhub namespace name- output to oher module subsystems"
  value       = [for eh in azurerm_eventhub_authorization_rule.this : eh.namespace_name]
}

output "eventhub_namespace" {
  description = "azurerm_eventhub_namespace resource"
  value       = azurerm_eventhub_namespace.this
}
