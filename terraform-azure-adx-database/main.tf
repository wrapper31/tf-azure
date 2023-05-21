data "azurerm_kusto_cluster" "this" {
  name                = var.adx_cluster.name
  resource_group_name = var.adx_cluster.resource_group_name
}

resource "azurerm_kusto_database" "this" {
  name                = var.database_name
  cluster_name        = data.azurerm_kusto_cluster.this.name
  location            = var.location
  resource_group_name = data.azurerm_kusto_cluster.this.resource_group_name

  hot_cache_period   = "P${var.cache_days}D"
  soft_delete_period = "P${var.retention_days}D"
}

resource "azurerm_management_lock" "prevent_destroy" {
  count = var.prevent_destroy ? 1 : 0

  name       = "PreventDestroy"
  scope      = azurerm_kusto_database.this.id
  lock_level = "CanNotDelete"
  notes      = "Care should be taken when deleting resources with data."

  lifecycle {
    prevent_destroy = true
  }
}
