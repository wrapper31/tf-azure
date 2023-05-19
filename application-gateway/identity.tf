resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.name_prefix}-id-agw-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"],
      tags["GM ASMS No"]
    ]
  }
}

resource "azurerm_role_assignment" "key_vault_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}
