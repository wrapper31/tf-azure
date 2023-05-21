variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "acronym" {
  type        = string
  description = "ASMS Acronym"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "resource_prefix_no_dash" {
  type        = string
  description = "Prefix for all resource names with no dashes (-)"
}

variable "asms_status" {
  type = string
}

variable "alternate_innovation_owner_email" {
  type = string
}

variable "alternate_operations_owner_email" {
  type = string
}

variable "business_function" {
  type = string
}

variable "business_sub_function" {
  type = string
}

variable "innovation_owner_email" {
  type = string
}

variable "operations_owner_email" {
  type = string
}

variable "owning_organization" {
  type = string
}

variable "key_vault_subnet_id" {
  type        = string
  description = "Subnet ID for Key Vault"
}

variable "app_gateway_subnet_id" {
  type        = string
  description = "Subnet ID for App Gateway"
}
