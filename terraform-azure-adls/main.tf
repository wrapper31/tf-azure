locals {
  resource_prefix         = "${var.asms}-${var.env}-${var.location_prefix}"
  resource_prefix_no_dash = "${var.asms}${var.env}${var.location_prefix}"
}

data "azurerm_client_config" "this" {
}

# ADLS Resource
resource "azurerm_storage_account" "this" {
  name                            = "${local.resource_prefix_no_dash}st${var.descriptor}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = "StorageV2"
  is_hns_enabled                  = "true"
  shared_access_key_enabled       = false
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.allow_ip_rules
    virtual_network_subnet_ids = var.allowed_subnet_ids
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

resource "azurerm_management_lock" "prevent_destroy" {
  count = var.prevent_destroy ? 1 : 0

  name       = "PreventDestroy"
  scope      = azurerm_storage_account.this.id
  lock_level = "CanNotDelete"
  notes      = "Care should be taken when deleting resources with data."

  lifecycle {
    prevent_destroy = true
  }
}

# Private Endpoint for ADLS
resource "azurerm_private_endpoint" "adls_private_endpoint" {
  depends_on                    = [azurerm_storage_account.this]
  name                          = "${local.resource_prefix}-pe-adls-${var.descriptor}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${local.resource_prefix}-nic-adls-${var.descriptor}"
  private_service_connection {
    name                           = "${local.resource_prefix}-pl-adls-${var.descriptor}"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }
  tags = var.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_role_assignment" "sbdo" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.this.object_id

  depends_on = [
    azurerm_storage_account.this
  ]
  lifecycle {
    ignore_changes = [
      role_definition_id, principal_id
    ]
  }
}
