variable "zone_name" {
  type        = string
  description = "DNS zone for records to be created in"
  default     = "ultifi.azure.ext.gm.com"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "a203578-p1-global-rg001-dns"
}

variable "env" {
  type        = string
  description = "Name of the deployment environment"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "verification_id" {
  type = string
}
