terraform {
  required_version = ">= 1.2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.21.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.13.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 0.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
