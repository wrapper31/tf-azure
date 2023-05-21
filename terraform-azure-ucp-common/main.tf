resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-rg-main"
  location = var.location
  tags = merge(local.tags, {
    "GM ASMS Status"                      = var.asms_status
    "GM Alternate Innovation Owner Email" = var.alternate_innovation_owner_email
    "GM Alternate Operations Owner Email" = var.alternate_operations_owner_email
    "GM Application Acronym"              = upper(var.acronym)
    "GM Business Function"                = var.business_function
    "GM Business Sub Function"            = var.business_sub_function
    "GM Innovation Owner Email"           = var.innovation_owner_email
    "GM Operations Owner Email"           = var.operations_owner_email
    "GM Owning Organization"              = var.owning_organization
  })
}

resource "azurerm_service_plan" "tf_ucp" {
  name                = "${var.resource_prefix}-asp-main"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P3v3"
  tags                = local.tags
}

resource "azapi_resource" "storage_account" {
  type      = "Microsoft.Storage/storageAccounts@2021-09-01"
  name      = "${var.resource_prefix_no_dash}st"
  parent_id = azurerm_resource_group.rg.id
  location  = var.location

  body = jsonencode({
    sku = {
      name = "Standard_ZRS"
    }
    kind = "Storage"
    properties = {
      publicNetworkAccess = "Disabled"
      networkAcls = {
        defaultAction = "Deny"
      }
    }
  })
}

module "key_vault" {
  source                     = "../terraform-azure-key-vault"
  resource_group_name        = azurerm_resource_group.rg.name
  resource_group_id          = azurerm_resource_group.rg.id
  name_prefix                = var.resource_prefix
  descriptor                 = "0main"
  location                   = var.location
  subnet_id                  = var.key_vault_subnet_id
  key_vault_private_key_name = "vmprivatekey"
  key_vault_public_key_name  = "vmpublickey"
  key_vault_openssh_name     = "vmsshkey"
  tags                       = local.tags
}
