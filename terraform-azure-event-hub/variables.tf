variable "resource_group_name" {
  description = "Resource group name where resource should be deployed"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for the resource"
  type        = string
}

variable "descriptor" {
  description = "Descriptor for the resource"
  type        = string
}

variable "location" {
  description = "Azure location where resources should be deployed"
  type        = string
}

variable "sku" {
  description = "Defines which tier to use. Valid options are Basic and Standard"
}

variable "event_hub" {
  description = "A list of event hubs to add to namespace"
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    authorization = object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    })
  }))
}

variable "capacity" {
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace. Valid values range from 1 - 20"
  type        = number
  default     = 1
}

variable "auto_inflate" {
  description = "Is Auto Inflate enabled for the EventHub Namespace, and what is maximum throughput?"
  type = object({
    enabled                  = bool
    maximum_throughput_units = number
  })
  default = null
}

variable "subnet_id" {
  description = "Subnet id of the private endpoint tied to event hub"
  type        = string
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

// azure event hub namesapce logs https://learn.microsoft.com/en-us/azure/event-hubs/monitor-event-hubs-reference#resource-logs
variable "diagnostic_logs" {
  description = "A list of logs to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/event-hubs/monitor-event-hubs-reference#resource-logs"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  # default = null
  default = [
    {
      category          = "ArchiveLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "OperationalLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "AutoScaleLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "KafkaCoordinatorLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "KafkaUserErrorLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "EventHubVNetConnectionEvent"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "CustomerManagedKeyUserLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "RuntimeAuditLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ApplicationMetricsLogs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

// azure event hub namespace metrics https://learn.microsoft.com/en-us/azure/aks/monitor-aks-reference#metrics
variable "diagnostic_metrics" {
  description = "value is a list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/aks/monitor-aks-reference#metrics"
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
  description = "Tags to apply to all resources created"
  type        = map(string)
}

variable "is_public_network_access_enabled" {
  description = "Is public network access enabled"
  type        = bool
  default     = false
}

variable "allow_all_public_networks" {
  description = "Enables public network access and allows all networks"
  type        = bool
  default     = false
}

variable "local_authentication_enabled" {
  description = "Enables Local Authentication"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "set minimum tls version"
  type        = string
  default     = "1.2"
}
