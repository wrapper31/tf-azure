variable "resource_group_name" {
  type        = string
  description = "The Resouce group name to provision resources"
}

variable "name_prefix" {
  type        = string
  description = "The prefix name.i.e. a210298-s1-musea2"
}

variable "name_prefix_no_dash" {
  type        = string
  description = "The prefix name wothout dashes.i.e. a210298s1musea2"
}

variable "descriptor" {
  type        = string
  description = "The descriptor which will added at the end of the resource name"
}

variable "location" {
  type        = string
  description = "The location where resources need to be build"
}

variable "subnet_id" {
  type        = string
  description = "The subnet id which you want to refere for your resource provisioning"
}

variable "tags" {
  type        = map(any)
  description = "The tag name (key=value)"
}

variable "enable_private_endpoint" {
  description = "Create a private endpoint for the container registry"
  type        = bool
  default     = false
}

variable "sku" {
  description = "The SKU used for the creation of the container registry"
  type        = string
  default     = "Premium"
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to be allowed to access the ACR"
  default     = []
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent"
  type        = string
  default     = null
}

variable "allowed_ips" {
  type        = list(string)
  description = "White list IP addresses - typically, GM VPN IP"
  default     = []
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for the container registry. Defaults to true."
  default     = true
}

variable "prevent_destroy" {
  description = "Prevent the resource from being destroyed by Terraform by creating a lock, can be bypassed by manually deleting the lock"
  type        = bool
  default     = true
}
