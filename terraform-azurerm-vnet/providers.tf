terraform {
  required_version = ">= 1.2.0"
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.21.0"
      configuration_aliases = [azurerm.hub]
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.3"
    }
  }
}