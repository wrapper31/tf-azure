variable "resource_group_name" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "descriptor" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "databases" {
  type = list(object({
    name = string
    containers = map(object({
      partition_key_path = string
      unique_keys        = list(string)
      indexing_mode      = string
      included_paths     = list(string)
      excluded_paths     = list(string)
      default_timetolive = number
    }))
  }))
  description = "List of databases with multiple containers"
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

variable "public_network_access_enabled" {
  description = "Enable public access from the GM address space, requires policy exemption"
  type        = bool
  default     = false
}

variable "local_authentication_enabled" {
  description = "Enable local authentication (non AAD access)"
  type        = bool
  default     = false
}

variable "access_key_metadata_writes_enabled" {
  description = "Enable applications to do things like create containers and databases"
  type        = bool
  default     = true
}

variable "tags" {
  type = map(any)
}

// azure cosmos db logs describe here https://learn.microsoft.com/en-us/azure/cosmos-db/monitor-resource-logs
// categories https://learn.microsoft.com/en-us/azure/cosmos-db/monitor-resource-logs#categories
variable "diagnostic_logs" {
  description = "categories of logs to be enabled see https://docs.microsoft.com/en-us/azure/cosmos-db/monitor-resource-logs#categories"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  # default = null
  default = [
    {
      category          = "DataPlaneRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "MongoRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "QueryRuntimeStatistics"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "PartitionKeyStatistics"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "PartitionKeyRUConsumption"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ControlPlaneRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "CassandraRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "GremlinRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "TableApiRequests"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

// azure cosmos db metrics described here https://learn.microsoft.com/en-us/azure/cosmos-db/insights-overview
variable "diagnostic_metrics" {
  description = "values of metrics to be enabled see https://docs.microsoft.com/en-us/azure/cosmos-db/monitor-resource-logs#metrics"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [{
    category          = "Requests"
    enabled           = true
    retention_days    = 30
    retention_enabled = true
  }]
}

variable "prevent_destroy" {
  description = "Prevent the resource from being destroyed by Terraform by creating a lock, can be bypassed by manually deleting the lock"
  type        = bool
  default     = true
}
