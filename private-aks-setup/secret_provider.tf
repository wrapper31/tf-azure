resource "azurerm_user_assigned_identity" "csi_driver" {
  count = var.ingress_enabled ? 1 : 0

  location            = var.location
  name                = "${var.name_prefix}-msi-csi-${var.descriptor}"
  resource_group_name = var.resource_group_name

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_role_assignment" "csi_driver_key_vault_user" {
  count = var.ingress_enabled ? 1 : 0

  scope                = var.ingress_key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.csi_driver[0].principal_id
}

resource "kubectl_manifest" "secret_provider_class" {
  count = var.ingress_enabled ? 1 : 0

  yaml_body = templatefile("${path.module}/secret-provider-class.yaml", {
    class_name         = local.csi_secret_provider_class_name
    namespace          = var.namespace,
    secret_name        = local.csi_secret_name
    key_vault_name     = var.ingress_key_vault_name,
    certificate_name   = var.ingress_certificate_name,
    identity_client_id = azurerm_user_assigned_identity.csi_driver[0].client_id,
    tenant_id          = azurerm_user_assigned_identity.csi_driver[0].tenant_id
  })

  depends_on = [
    azurerm_federated_identity_credential.this,
    azurerm_role_assignment.csi_driver_key_vault_user
  ]
}
