variable "resource_group_name" {
  description = "The Resouce group name to provision resources"
  type        = string
}
variable "name_prefix" {
  description = "The prefix name.i.e. a210298-s1-musea2"
  type        = string
}

variable "descriptor" {
  description = "The descriptor which will added at the end of the resource name"
  type        = string
}

variable "location" {
  description = "Resource location"
  type        = string
}

variable "app_svc_plan_os_type" {
  description = "App Service Plan OS Type"
  type        = string
  default     = "Linux"
}
variable "app_svc_plan_sku_name" {
  description = "App Service Plan SKU Name"
  type        = string
  default     = "P1v3"
}

variable "tags" {
  description = "The tag name (key=value)"
  type        = map(any)
}
