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

variable "descriptor" {
  type = string
}

variable "kv_id" {
  type = string
}

variable "allow_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format"
  default     = ["198.208.0.0/16"]
}

variable "dbw_resource_object_id" {
  type        = string
  description = "Application ID of Azure Databricks"
  default     = "ceffa7af-f110-4550-bf03-64fab66a2384"
}

variable "dbw_adls_ids" {
  description = "List of ADLS Storage Account IDs"
  type        = list(string)
}

variable "tags" {
  type = map(any)
}

variable "vnet_id" {
  description = "VNET ID of where Databricks workspace should be injected"
  type        = string
}

variable "dbw_subnet_public_name" {
  description = "Public subnet name for Databricks host"
  type        = string
}

variable "dbw_subnet_public_nsg_id" {
  description = "Network Security Group ID of public subnet of Databricks host"
  type        = string
}

variable "dbw_subnet_private_name" {
  description = "Private subnet name for Databricks compute"
  type        = string
}

variable "dbw_subnet_private_nsg_id" {
  description = "Network Security Group ID of private subnet of Databricks compute"
  type        = string
}

variable "dbw_subnet_private_endpoint_id" {
  description = "Subnet Id to create private endpoint for Databricks workspace"
  type        = string
}

variable "groups" {
  description = "A map to create multiple databricks workspace groups"
  type = map(object({
    display_name               = string
    allow_cluster_create       = bool
    allow_instance_pool_create = bool
    databricks_sql_access      = bool
    workspace_access           = bool
  }))
  default = {}
}

variable "users" {
  description = "A map to create multiple databricks workspace users"
  type = map(object({
    user_name    = string
    display_name = string
  }))
  default = {}
}

variable "group_users" {
  description = "A map to map users to groups"
  type = map(object({
    group_key = string
    user_key  = string
  }))
  default = {}
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
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/databricks/administration-guide/account-settings/azure-diagnostic-logs#events"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "accounts"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "clusters"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "instancePools"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "jobs"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "notebook"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "unityCatalog"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "workspace"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}
variable "is_customer_managed_key_enabled" {
  description = "Is customer managed key enabled"
  type        = bool
  default     = false
}
