variable "env" {
  type        = string
  description = "Name of the deployment environment"
}

variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group"
}

variable "location_prefix" {
  type        = string
  description = "Location prefix of the azure resource group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the storage account endpoint"
}

variable "descriptor" {
  type = string
}

variable "account_tier" {
  type        = string
  description = "Storage Account Tier (Standard | Premium)"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Storage Account Tier (LRS | GRS | RAGRS | ZRS | GZRS | RAGZRS)"
  default     = "LRS"
}

variable "allow_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format"
  default     = ["198.208.0.0/16"]
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of allowed Subnet Ids for storage account network access"
}

variable "enable_diagnostics" {
  type        = bool
  description = "Whether or not to send logs and metrics to a Log Analytics Workspace"
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled_diagnostics is true"
  type        = string
  default     = null
}

variable "diagnostic_logs" {
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage-reference#resource-logs-preview"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "StorageRead"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "StorageWrite"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "StorageDelete"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

variable "diagnostic_metrics" {
  description = "value is a list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage-reference#metrics-dimensions"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [{
    category          = "AllMetrics"
    enabled           = true
    retention_days    = 30
    retention_enabled = true
  }]
}

variable "tags" {
  type = map(any)
}

variable "prevent_destroy" {
  description = "Prevent the resource from being destroyed by Terraform by creating a lock, can be bypassed by manually deleting the lock"
  type        = bool
  default     = true
}
