variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "name_prefix" {
  type        = string
  description = "The prefix name.i.e. a210298-s1-musea2"
}

variable "name_prefix_no_dash" {
  type        = string
  description = "The prefix name wothout dashes.i.e. a210298s1musea2"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "descriptor" {
  type        = string
  description = "descriptor of the azure resource group"
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
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/databricks/administration-guide/account-settings/azure-diagnostic-logs#events"
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
    },
    {
      category          = null
      category_group    = "audit"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

variable "pvtnet_access_enabled" {
  description = "Private Newtwork Access - true = allow / false = deny"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Public endpoints allow access to this resource through the internet using a public IP address."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Subnet id of the private endpoint tied to grafana"
  type        = string
}

variable "grafana_role_assignment" {
  type        = map(any)
  description = "List of Role (Reader, Contributor) to be assigned at the grafana"
  default     = {}
}

variable "monitoring_reader_scope" {
  type        = list(string)
  description = "List of Resource ID for the monitoring reader role scope"
  default     = []
}
