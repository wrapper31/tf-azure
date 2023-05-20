terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54"
    }
  }
}

provider "azurerm" {
  storage_use_azuread        = true
  skip_provider_registration = "true"
  features {
    key_vault {
      recover_soft_deleted_certificates = true
      recover_soft_deleted_key_vaults   = true
      purge_soft_delete_on_destroy      = false
    }
  }
}
