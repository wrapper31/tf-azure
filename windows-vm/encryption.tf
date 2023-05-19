resource "azurerm_key_vault_key" "this" {
  name         = "${var.name_prefix}-vm-${var.descriptor}-encryption"
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_disk_encryption_set" "this" {
  name                      = "${var.name_prefix}-vm-${var.descriptor}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  key_vault_key_id          = azurerm_key_vault_key.this.id
  auto_key_rotation_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_role_assignment" "encryption" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_disk_encryption_set.this.identity[0].principal_id
}

resource "azurerm_virtual_machine_extension" "encryption" {
  name                 = "${var.name_prefix}-install-encryption"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Security"
  type                 = "AzureDiskEncryption"
  type_handler_version = 2.2

  settings = jsonencode({
    "EncryptionOperation" : "EnableEncryption",
    "KeyVaultURL" : "https://${var.key_vault_name}.vault.azure.net/",
    "KeyVaultResourceId" : var.key_vault_id,
    "KeyEncryptionKeyURL" : azurerm_key_vault_key.this.id,
    "KekVaultResourceId" : var.key_vault_id,
    "KeyEncryptionAlgorithm" : "RSA-OAEP",
    "VolumeType" : "All"
  })

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }

  depends_on = [
    azurerm_role_assignment.encryption
  ]
}
