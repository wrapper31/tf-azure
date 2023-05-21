locals {
  name_prefix = "${var.asms}-${var.env}-${var.location_prefix}"
}

data "azurerm_client_config" "this" {
}
resource "azurerm_key_vault_key" "this" {
  name         = "CustManagedKeyDBW"
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
resource "null_resource" "this" {
  provisioner "local-exec" {
    command = <<EOT
            az config set extension.use_dynamic_install=yes_without_prompt
            az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID  -o table
            az account set --subscription $ARM_SUBSCRIPTION_ID
            az databricks workspace update -g "${var.resource_group_name}" -n "${azurerm_databricks_workspace.this.name}" --prepare-encryption -o table
    EOT
  }
}
data "azurerm_databricks_workspace" "this" {
  depends_on          = [null_resource.this]
  name                = azurerm_databricks_workspace.this.name
  resource_group_name = var.resource_group_name
}
resource "azurerm_role_assignment" "this" {
  scope                = var.kv_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = data.azurerm_databricks_workspace.this.storage_account_identity.0.principal_id
  depends_on           = [azurerm_key_vault_key.this, null_resource.this]
}
resource "azurerm_databricks_workspace_customer_managed_key" "this" {
  depends_on       = [null_resource.this, azurerm_role_assignment.this]
  workspace_id     = azurerm_databricks_workspace.this.id
  key_vault_key_id = azurerm_key_vault_key.this.id
}
resource "azurerm_databricks_workspace" "this" {
  name                              = "${local.name_prefix}-dbw-${var.descriptor}"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  sku                               = "premium"
  infrastructure_encryption_enabled = true
  customer_managed_key_enabled      = var.is_customer_managed_key_enabled

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = var.vnet_id
    public_subnet_name                                   = var.dbw_subnet_public_name
    public_subnet_network_security_group_association_id  = var.dbw_subnet_public_nsg_id
    private_subnet_name                                  = var.dbw_subnet_private_name
    private_subnet_network_security_group_association_id = var.dbw_subnet_private_nsg_id
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

resource "databricks_workspace_conf" "this" {
  custom_config = {
    "enableIpAccessLists" : true,
    "enableVerboseAuditLogs" : true
  }
  depends_on = [azurerm_databricks_workspace.this]
}

# resource "databricks_ip_access_list" "allowed-list" {
#   label        = "allow_workspace_access_from_GM_IPs_only"
#   list_type    = "ALLOW"
#   ip_addresses = var.allow_ip_rules
#   depends_on   = [databricks_workspace_conf.this]
# }

resource "azurerm_private_endpoint" "databricks" {
  name                          = "${local.name_prefix}-pe-dbw-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.dbw_subnet_private_endpoint_id
  custom_network_interface_name = "${local.name_prefix}-nic-dbw-${var.descriptor}"

  private_service_connection {
    name                           = "${local.name_prefix}-pl-dbw-${var.descriptor}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.this.id
    subresource_names              = ["databricks_ui_api"]
  }
  depends_on = [
    azurerm_databricks_access_connector.this, azurerm_databricks_workspace.this, azurerm_databricks_workspace_customer_managed_key.this
  ]
  tags = var.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }

}

resource "azurerm_databricks_access_connector" "this" {
  depends_on          = [azurerm_databricks_workspace.this]
  name                = "${local.name_prefix}-dbwac-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location

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

resource "azurerm_role_assignment" "sbdo" {
  count = length(var.dbw_adls_ids)

  scope                = var.dbw_adls_ids[count.index]
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.this.identity.0.principal_id
  depends_on = [
    azurerm_databricks_workspace.this, azurerm_databricks_access_connector.this
  ]
}

resource "azurerm_role_assignment" "kvsu" {
  scope                = var.kv_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.dbw_resource_object_id
}
