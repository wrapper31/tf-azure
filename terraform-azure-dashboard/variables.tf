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
  description = "The descriptor which will be added at the end of the resource name"
}

variable "location" {
  type        = string
  description = "The location where resources need to be build"
}

variable "dashboard_properties" {
  type        = string
  description = "Filled in dashboard json - can be built from template file"
}

variable "tags" {
  type = map(any)
}
