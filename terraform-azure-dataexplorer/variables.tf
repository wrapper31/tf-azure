variable "env" {
  type        = string
  description = "Name of the deployment environment"
}

variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "resource_prefix" {
  description = "Prefix for all resource names"
  type        = string
}
variable "resource_group_name" {
  description = " Name of the resource group where the ADX Cluster will be created"
  type        = string
}


variable "location" {
  type        = string
  description = "Location of the azure resource group where the ADX Cluster will be created"
}

variable "location_prefix" {
  type        = string
  description = "Location prefix of the azure resource group"
}

variable "descriptor" {
  type = string
}

variable "subnet_id" {
  description = " subnet id where the private endpoint will be created"
  type        = string
}
variable "cluster_sku" {
  description = "sku of the data explorer"
  type        = string
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format"
  default     = ["198.208.0.0/16"]
}
variable "cluster_capacity" {
  description = "Node count of the Kusto cluster"
  type        = number
}
variable "auto_stop_enabled" {
  type    = bool
  default = true
}
variable "public_network_access" {
  type    = bool
  default = false
}
variable "allow_all_public_networks" {
  type    = bool
  default = false
}
variable "streaming_ingestion_enabled" {
  type    = bool
  default = false
}
variable "log_analytics_resource_id" {
  description = "workspace id for log analytics"
  type        = string
}
variable "enable_diagnostics" {
  type    = bool
  default = true
}
variable "diagnostic_logs" {
  description = "category of logs to be collected"
  type = set(object({
    category          = string
    category_group    = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [

    {
      category          = null
      category_group    = "allLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
    , {
      category          = null
      category_group    = "audit"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}
variable "diagnostic_metrics" {
  description = "value is a list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/data-factory/monitor-metrics-alerts"
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
