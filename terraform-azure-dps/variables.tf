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

variable "allocation_policy" {
  description = "The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static) "
  type        = string
  default     = "GeoLatency"
}

variable "subnet_id" {
  description = "Resource subnet"
  type        = string
}

variable "device_root_cert" {
  description = "The Base-64 representation of the X509 leaf certificate .cer file or just a .pem file content"
  type        = string
}

variable "pubnet_access_enabled" {
  description = "Public Network Access - true = allow / false = deny"
  type        = bool
  default     = false
}

variable "pvtnet_access_enabled" {
  description = "Private Network Access - true = allow / false = deny"
  type        = bool
  default     = true
}

variable "ip_filter_rule_ip_mask" {
  description = "The IP address range in CIDR notation for ip filter rule"
  type        = string
  default     = null
}

variable "ip_filter_rule_action" {
  description = "The desired action for ip filter rule- Accept/Reject"
  type        = string
  default     = "Accept"
}

variable "tags" {
  type = map(any)
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

// IoT Hub DPS Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/iot-dps/monitor-iot-dps-reference
variable "diagnostic_logs" {
  description = "categories of logs to be enabled"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "DeviceOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ServiceOperations"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

// IoT Hub DPS Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/iot-dps/monitor-iot-dps-reference
variable "diagnostic_metrics" {
  description = "values of metrics to be enabled"
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
