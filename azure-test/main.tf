terraform {
  required_version = "~> 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.21.1"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">=0.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.13.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "XXXX-XXXXX-XXXXXX"

  # skip_provider_registration = "true"
  # storage_use_azuread = true
  features {}
}
provider "kubernetes" {}
provider "azapi" {}


locals {
  env                     = var.developer_name
  asms                    = 210298
  location                = "EastUS2"
  location_prefix         = "musea2"
  resource_prefix         = "a${local.asms}-${local.env}-${local.location_prefix}"
  resource_prefix_no_dash = "a${local.asms}${local.env}${local.location_prefix}"
  resource_group_name     = "a210298-${var.developer_name}-s1-musea2-rg"
  descriptor              = "vs1"
  tags                    = {}
}

data "azurerm_resource_group" "test" {
  name = local.resource_group_name
}
