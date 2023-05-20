terraform {
  required_version = ">= 1.2.0"
  experiments      = [module_variable_optional_attrs]
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.39.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.0.0"
    }

  }
}
