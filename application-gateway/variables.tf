variable "name_prefix" {
  description = "The prefix name.i.e. a210298-s1-musea2"
  type        = string
}

variable "descriptor" {
  description = "The descriptor which will added at the end of the resource name"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Application Gateway"
  type        = string
}

variable "location" {
  description = "The location/region where the Application Gateway is created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID of the App gateway"
  type        = string
}


variable "key_vault_id" {
  description = "A key vault id for configuration of the application gateway to read secret"
  type        = string
}


variable "sku" {
  description = "A mapping with the sku configuration of the application gateway"
  type        = map(string)
}

variable "sku_public_ip" {
  description = "sku for public ip"
  type        = string
}

variable "sku_public_ip_tier" {
  description = "sku tier for public ip"
  type        = string
}

variable "autoscale_configuration" {
  description = "Autoscale configuration"
  type        = map(string)
  default     = {}
}

variable "frontend_port" {
  description = "List of objects that represent the configuration of each port"
  type        = list(map(string))
}

variable "backend_address_pools" {
  description = "List of objects that represent the configuration of each backend address pool"
  type        = list(map(string))
}

variable "http_listeners" {
  description = "List of objects that represent the configuration of each http listener"
  type        = list(map(string))
}

variable "ssl_certificates" {
  description = "List of objects that represent the configuration of each ssl certificate"
  type = map(object({
    name      = string
    secret_id = string
  }))
  default = {}
}

variable "trusted_client_certificates" {
  description = "ca public cert that clients are signed with"
  type        = list(map(string))
  default     = []
}

variable "backend_http_settings" {
  description = "List of backend HTTP settings"
  type        = set(map(string))
}

variable "request_routing_rules" {
  description = "List of objects that represent the configuration of each backend request routing rule"
  type        = list(map(string))
}

variable "rewrite_rule_sets" {
  description = "List of objects that represent the configuration of each rewrite rule set"
  type = set(object({
    name = string
    rewrite_rules = list(object({
      name          = optional(string)
      rule_sequence = optional(number)
      conditions = optional(list(object({
        variable    = string
        pattern     = string
        ignore_case = optional(bool)
        negate      = optional(bool)
      })))
      request_header_configurations = optional(list(object({
        header_name  = string
        header_value = string
      })))
      response_header_configurations = optional(list(object({
        header_name  = string
        header_value = string
      })))
    }))
  }))
  default = []
}

variable "probes" {
  type        = list(map(string))
  description = "List of objects that represent the configuration of each probe"
  default     = []
}

variable "enable_diagnostics" {
  description = "Whether or not to send logs and metrics to a Log Analytics Workspace"
  type        = bool
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled_diagnostics is true"
  type        = string
  default     = null
}

// App Gateway Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/application-gateway/monitor-application-gateway-reference
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
      category          = "ApplicationGatewayAccessLog"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ApplicationGatewayPerformanceLog"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ApplicationGatewayFirewallLog"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

// App Gateway Azure Monitor data reference @
// https://learn.microsoft.com/en-us/azure/application-gateway/monitor-application-gateway-reference
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

variable "tags" {
  type = map(any)
}


variable "ssl_policy" {
  type = object({
    policy_type          = string
    cipher_suites        = list(string)
    min_protocol_version = string
  })
  description = "(optional) configure ssl policy"
  default     = null
}

variable "ssl_profiles" {
  description = "ssl profile configuration to support mutual tls"
  type = list(object({
    name                             = string
    trusted_client_certificate_names = list(string)
  verify_client_cert_issuer_dn = string }))
  default = []
}
