resource "azurerm_app_service_custom_hostname_binding" "this" {
  count               = var.custom_domain_hostname != null ? 1 : 0
  hostname            = var.custom_domain_hostname
  app_service_name    = azurerm_linux_web_app.this.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_certificate" "this" {
  count               = var.certificate_name != null ? 1 : 0
  name                = var.certificate_name
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_secret_id = var.certificate_secret_id
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_app_service_certificate_binding" "this" {
  count               = var.custom_domain_hostname != null ? 1 : 0
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.this[0].id
  certificate_id      = azurerm_app_service_certificate.this[0].id
  ssl_state           = "SniEnabled"
}
