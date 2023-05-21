output "id" {
  description = "Dataexplorer ID"
  value       = azurerm_kusto_cluster.this.id
}
output "name" {
  description = "Dataexplorer Name"
  value       = azurerm_kusto_cluster.this.name
}
output "resource_group_name" {
  description = "Dataexplorer resource_group_name"
  value       = azurerm_kusto_cluster.this.resource_group_name
}

output "cluster_identity_name" {
  description = "Kusto cluster user assigned identity"
  value       = azurerm_user_assigned_identity.cluster_identity.name
}
