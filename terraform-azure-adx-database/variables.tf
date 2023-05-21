
variable "database_name" {
  type        = string
  description = "name of the ADX database to create"
}

variable "adx_cluster" {
  description = "ADX cluster to create the database in"
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "location" {
  type        = string
  description = "Location of the azure resource group where the ADX Cluster will be created"
}

variable "retention_days" {
  description = "Days to keep data"
  type        = number
  default     = 30
}

variable "cache_days" {
  description = "Days that the data that should be kept in cache for fast queries"
  type        = number
  default     = 5
}

variable "prevent_destroy" {
  description = "Prevent the resource from being destroyed by Terraform by creating a lock, can be bypassed by manually deleting the lock"
  type        = bool
  default     = true
}
