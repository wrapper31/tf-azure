resource "databricks_group" "this" {
  depends_on = [azurerm_databricks_workspace.this]

  for_each                   = var.groups
  display_name               = each.value["display_name"]
  allow_cluster_create       = each.value["allow_cluster_create"]
  allow_instance_pool_create = each.value["allow_instance_pool_create"]
  databricks_sql_access      = each.value["databricks_sql_access"]
  workspace_access           = each.value["workspace_access"]
}

resource "databricks_user" "this" {
  depends_on = [azurerm_databricks_workspace.this]

  for_each     = var.users
  user_name    = each.value["user_name"]
  display_name = each.value["display_name"]
}

resource "databricks_group_member" "this" {
  depends_on = [
    databricks_group.this,
    databricks_user.this
  ]

  for_each  = var.group_users
  group_id  = databricks_group.this[each.value["group_key"]].id
  member_id = databricks_user.this[each.value["user_key"]].id
}
