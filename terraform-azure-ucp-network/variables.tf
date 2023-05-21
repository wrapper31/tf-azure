variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of virtual network"
}

variable "iot_hub_address_space" {
  type        = string
  description = "CIDR IP range for IoT Hub"
}

variable "event_hub_address_space" {
  type        = string
  description = "CIDR IP range for Event Hub"
}

variable "event_grid_address_space" {
  type        = string
  description = "CIDR IP range for Event Grid"
}

variable "functions_address_space" {
  type        = string
  description = "CIDR IP range for Functions"
}

variable "service_bus_address_space" {
  type        = string
  description = "CIDR IP range for Service Bus"
}

variable "aks_address_space" {
  type        = string
  description = "CIDR IP range for AKS"
}

variable "dev_portal_address_space" {
  type        = string
  description = "CIDR IP range for Dev Portal"
}

variable "storage_account_address_space" {
  type        = string
  description = "CIDR IP range for Storage Account"
}

variable "key_vault_address_space" {
  type        = string
  description = "CIDR IP range for Key Vault"
}

variable "app_service_address_space" {
  type        = string
  description = "CIDR IP range for App Service"
}

variable "cosmos_db_address_space" {
  type        = string
  description = "CIDR IP range for Cosmos DB"
}

variable "app_gateway_address_space" {
  type        = string
  description = "CIDR IP range for App Gateway"
}
