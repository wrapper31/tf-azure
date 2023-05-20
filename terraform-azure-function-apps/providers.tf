terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 0.4.0"
    }
  }
}
