terraform {
  required_version = ">= 1.2"
  experiments      = [module_variable_optional_attrs]

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.28"
    }
    # we need this here as nested modules cant resolve the azapi from terraform registry
    azapi = {
      source  = "Azure/azapi"
      version = ">=1.1.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
