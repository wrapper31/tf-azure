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
  }
}
