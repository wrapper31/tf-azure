variable "resource_group_name" {
  type = string
}

variable "resource_group_id" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "name_prefix_no_dash" {
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

variable "service_plan_id" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "app_insights_name" {
  type        = string
  description = "Name of existing app insights instance to write traces to"
}

variable "app_insights_resource_group_name" {
  type        = string
  description = "Name of resource group containing existing app insights instance"
}

variable "tags" {
  type = map(any)
}

variable "app_settings" {
  type    = map(any)
  default = {}
}
variable "outbound_subnet_id" {
  description = "The ID of the outbound subnet for the Vnet Integration"
  type        = string
}
variable "java_version" {
  description = "Java Version"
  type        = string
  default     = null
}
variable "python_version" {
  description = "Paython Version"
  type        = string
  default     = null
}
