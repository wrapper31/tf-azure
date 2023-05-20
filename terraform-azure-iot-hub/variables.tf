variable "eventhub_namespace_vsu_id" {
  description = "Eventhub VSU namespace ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name that module is connected to"
  type        = string
}

variable "name_prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "descriptor" {
  description = "Resource name descriptor"
  type        = string
}

variable "location" {
  description = "Resource location"
  type        = string
}

variable "sku" {
  description = "IoT Hub SKU"
  type        = string
  default     = "S1"
  validation {
    condition     = contains(["B1", "B2", "B3", "F1", "S1", "S2", "S3"], var.sku)
    error_message = "Invalid IoT Hub SKU"
  }
}

variable "units" {
  description = "The number of provisioned IoT Hub units"
  type        = number
  default     = 1
}

variable "event_hub_routes" {
  description = "Eventhub route list"
  type = list(object({
    condition = string
    endpoint = object({
      name           = string
      namespace_name = string
    })
  }))
  default = []
}

variable "event_grid_subscriptions" {
  description = "Map of tuples of event types to subscribe to, and the event hub ids to notify"
  type = map(object({
    event_types  = list(string)
    event_hub_id = string
  }))
  default = {}
}

variable "subnet_id" {
  description = "Resource subnet"
  type        = string
}

variable "pubnet_access_enabled" {
  description = "Public Newtwork Access - true = allow / false = deny"
  type        = bool
  default     = false
}

variable "pvtnet_access_enabled" {
  description = "Private Newtwork Access - true = allow / false = deny"
  type        = bool
  default     = true
}

variable "netrule_default_action" {
  description = "Default Action for Network Rule Set- Deny/Allow"
  type        = string
  default     = "Allow"
}

variable "netrule_to_builtin_evnthub_endpt" {
  description = "Determines if Network Rule Set is also applied to the BuiltIn EventHub EndPoint of the IotHub"
  type        = bool
  default     = false
}

variable "iprule_ipmask" {
  description = "The IP address range in CIDR notation for ip filter rule"
  type        = string
  default     = null
}

variable "iprule_action" {
  description = "The desired action for ip filter rule- Accept/Reject"
  type        = string
  default     = "Accept"
}

variable "resource_group_id" {
  description = "Parent resource group ID"
  type        = string
}

variable "dps_name" {
  description = "DPS-name input from DPS module subsystem"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(any)
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
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/iot-hub/monitor-iot-hub"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "Connections"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "DeviceTelemetry"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "C2DCommands"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "DeviceIdentityOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "FileUploadOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "Routes"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "D2CTwinOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "C2DTwinOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "TwinQueries"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "JobsOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "DirectMethods"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "DistributedTracing"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "Configurations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "DeviceStreams"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}
// azure kubernetes service metrics https://learn.microsoft.com/en-us/azure/iot-hub/tutorial-use-metrics-and-diags
variable "diagnostic_metrics" {
  description = "category of metrics to be collected see https://learn.microsoft.com/en-us/azure/iot-hub/tutorial-use-metrics-and-diags"
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

// Event Grid Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/event-grid/enable-diagnostic-logs-topic
variable "eventgrid_diagnostic_logs" {
  description = "category of logs to be collected"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "DeliveryFailures"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

// Event Grid Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/event-grid/enable-diagnostic-logs-topic
variable "eventgrid_diagnostic_metrics" {
  description = "category of metrics to be collected"
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
