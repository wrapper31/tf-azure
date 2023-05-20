variable "resource_group_name" {
  description = "Resource group name where resource should be deployed"
  type        = string
}

variable "consumer_groups" {
  description = "A list of consumer groups"
  type        = set(string)
}

variable "event_hub_namespace" {
  description = "Namespace of the event hub"
  type        = string
}

variable "event_hub_name" {
  description = "Name of the event hub to add consumer groups"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources created"
  type        = map(string)
}
