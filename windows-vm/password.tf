# If create password is true we create a random password and store it in the key vault. If create password is false we get the password from the key vault.

data "azurerm_key_vault_secret" "admin" {
  count = var.create_password ? 0 : 1

  name         = var.admin_password_name
  key_vault_id = var.key_vault_id
}

resource "random_password" "admin" {
  count = var.create_password ? 1 : 0

  length      = 10
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  special     = true
}

resource "azurerm_key_vault_secret" "admin" {
  count = var.create_password ? 1 : 0

  name         = var.admin_password_name
  value        = random_password.admin[0].result
  key_vault_id = var.key_vault_id

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
