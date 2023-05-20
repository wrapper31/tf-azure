variable "resource_group_name" {
  description = "The Resouce group name to provision resources"
  type        = string
}

variable "resource_group_id" {
  description = "Parent resource group ID"
  type        = string
}

variable "name_prefix" {
  description = "The prefix name.i.e. a210298-s1-musea2"
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

variable "enable_diagnostics" {
  type        = bool
  description = "Whether or not to send logs and metrics to a Log Analytics Workspace"
  default     = false
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled_diagnostics is true"
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags"
  type        = map(any)
}

variable "client_certs" {
  description = "List of client certificates to be added to the broker. Max 4"
  type        = list(string)
}

variable "api_version" {
  type        = string
  description = "API version to use for the resource"
  default     = ""
}
