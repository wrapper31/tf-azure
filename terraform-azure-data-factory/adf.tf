data "azurerm_client_config" "this" {
}
resource "azurerm_key_vault_key" "cmk" {
  name         = "CustManagedKey"
  key_vault_id = var.kv_id
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
}
resource "azurerm_role_assignment" "kv_role" {
  scope                = var.kv_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}
resource "azurerm_user_assigned_identity" "this" {
  name                = "${local.name_prefix}-id-adf-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
resource "azurerm_data_factory" "this" {
  name                             = "${local.name_prefix}-adf-${var.descriptor}"
  location                         = var.location
  resource_group_name              = var.resource_group_name
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled
  public_network_enabled           = var.public_network_enabled
  customer_managed_key_id          = azurerm_key_vault_key.cmk.id
  customer_managed_key_identity_id = azurerm_user_assigned_identity.this.id
  depends_on                       = [azurerm_role_assignment.kv_role]
  dynamic "github_configuration" {
    for_each = var.github_configuration != null ? [var.github_configuration] : []
    content {
      git_url         = github_configuration.value.git_url
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }

  dynamic "global_parameter" {
    for_each = var.global_parameters
    content {
      name  = global_parameter.key
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
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

resource "azurerm_data_factory_integration_runtime_self_hosted" "this" {
  for_each = var.self_hosted_integration_runtime

  name            = each.key
  data_factory_id = azurerm_data_factory.this.id
  description     = each.value.description
}

resource "azurerm_data_factory_integration_runtime_azure" "this" {
  for_each = var.azure_integration_runtime

  name                    = each.key
  data_factory_id         = azurerm_data_factory.this.id
  location                = var.location
  description             = each.value.description
  compute_type            = each.value.compute_type
  core_count              = each.value.core_count
  time_to_live_min        = each.value.time_to_live_min
  cleanup_enabled         = each.value.cleanup_enabled
  virtual_network_enabled = each.value.virtual_network_enabled
}

# Private endpoint for Azure Data Factory Instance
resource "azurerm_private_endpoint" "adfy" {
  depends_on = [azurerm_data_factory.this]

  name                          = "${local.name_prefix}-pe-adfy-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${local.name_prefix}-nic-adfy-${var.descriptor}"
  private_service_connection {
    name                           = "${local.name_prefix}-pl-adfy-${var.descriptor}"
    private_connection_resource_id = azurerm_data_factory.this.id
    is_manual_connection           = false
    subresource_names              = ["dataFactory"]
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

# Private endpoint for Azure Data Factory Portal
resource "azurerm_private_endpoint" "adfp" {
  depends_on = [azurerm_private_endpoint.adfy]

  name                          = "${local.name_prefix}-pe-adfp-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${local.name_prefix}-nic-adfp-${var.descriptor}"
  private_service_connection {
    name                           = "${local.name_prefix}-pl-adfp-${var.descriptor}"
    private_connection_resource_id = azurerm_data_factory.this.id
    is_manual_connection           = false
    subresource_names              = ["portal"]
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

resource "azurerm_key_vault_access_policy" "this" {
  #depends_on   = [azurerm_key_vault.this, azurerm_data_factory.this]
  depends_on   = [azurerm_data_factory.this]
  key_vault_id = var.kv_id

  tenant_id = data.azurerm_client_config.this.tenant_id
  object_id = azurerm_data_factory.this.identity.0.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  key_permissions = [
    "Get",
    "Decrypt",
    "Encrypt",
    "Sign",
    "UnwrapKey",
    "Verify",
    "WrapKey",
  ]

  certificate_permissions = [
    "Get"
  ]
}

resource "azurerm_role_assignment" "sbdo" {
  count = length(var.adf_adls_ids)

  scope                = var.adf_adls_ids[count.index]
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_data_factory.this.identity.0.principal_id
  depends_on = [
    azurerm_data_factory.this
  ]
}

resource "azurerm_role_assignment" "dbwrole" {
  scope                = var.adf_dbw_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_data_factory.this.identity.0.principal_id
  depends_on = [
    azurerm_data_factory.this
  ]
}
