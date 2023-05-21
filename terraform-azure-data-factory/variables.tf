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

variable "resource_prefix" {
  description = "Prefix for the resource"
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the private endpoint"
}

variable "descriptor" {
  type = string
}

variable "allow_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format"
  default     = ["198.208.0.0/16"]
}

variable "managed_virtual_network_enabled" {
  type        = bool
  description = "Is Managed Virtual Network enabled for ADF"
  default     = true
}

variable "public_network_enabled" {
  type        = bool
  description = "Is the Data Factory visible to the public network? "
  default     = false
}

variable "github_configuration" {
  description = "An input object to define the settings for connecting to GitHub. You must log in to the Data Factory management UI to complete the authentication to the GitHub repository."
  type = object({
    git_url         = string
    account_name    = string
    repository_name = string
    branch_name     = string
    root_folder     = string
  })
  default = null
}

variable "global_parameters" {
  type        = any
  description = "An input object to define a global parameter. Accepts multiple entries."
  default     = {}
}

variable "self_hosted_integration_runtime" {
  description = "Map Object to define any Azure self hosted Integration Runtime"
  type = map(object({
    description = string
  }))
  default = {}
}

variable "azure_integration_runtime" {
  type = map(object({
    description             = string
    compute_type            = string
    virtual_network_enabled = string
    core_count              = number
    time_to_live_min        = number
    cleanup_enabled         = bool
  }))
  description = "Map Object to define any Azure Integration Runtime nodes that required"
  default     = {}
}

variable "adf_adls_ids" {
  description = "List of ADLS Storage Account IDs"
  type        = list(string)
}

variable "adf_dbw_id" {
  description = "Databricks Workspace ID"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
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

variable "diagnostic_logs" {
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/data-factory/monitor-schema-logs-events"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "ActivityRuns"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "PipelineRuns"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "TriggerRuns"
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
