variable "resource_group_name" {
  type        = string
  description = "The Resouce group name to provision resources"
}

variable "name_prefix" {
  type        = string
  description = "The prefix name.i.e. a210298-s1-musea2"
}

variable "descriptor" {
  type        = string
  description = "The descriptor which will added at the end of the resource name"
}

variable "location" {
  type        = string
  description = "The location where resources need to be build"
}

variable "enable_local_authentication" {
  type        = bool
  description = "Enabling local authentication, excludes AD based authentication"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "The tag name (key=value)"
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent"
  type        = string
}

variable "application_type" {
  description = "Specifies the type of Application Insights to create. Unmatched values are treated as web"
  type        = string
  default     = "other"
}
