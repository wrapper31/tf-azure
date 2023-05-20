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
  subscription_id = "3c6bceca-96ab-4a3d-9c83-4c8306396e73"
  # subscription_id = "e06b3992-dbb3-45e8-bd7a-b8b557bb8c94"
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
