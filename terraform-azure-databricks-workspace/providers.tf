terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.39.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.0.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}
provider "azurerm" {
  # The storage_use_azuread flag should be enabled to overcome the below error
  # KeyBasedAuthenticationNotPermitted - Key based authentication is not permitted on ADLS storage account
  storage_use_azuread = true
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
}
