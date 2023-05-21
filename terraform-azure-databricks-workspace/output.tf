output "dbw_id" {
  description = "Databricks Workspace ID"
  value       = azurerm_databricks_workspace.this.id
}

output "dbw_url" {
  description = "Databricks Workspace URL"
  value       = azurerm_databricks_workspace.this.workspace_url
}
