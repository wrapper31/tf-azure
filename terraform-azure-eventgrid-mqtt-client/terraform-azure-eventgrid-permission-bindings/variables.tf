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

variable "tags" {
  description = "Resource tags"
  type        = map(any)
}

variable "mqtt_broker_id" {
  description = "Resource ID of the MQTT broker namespace"
  type        = string
}

variable "topic_name" {
  type        = string
  description = "Name of Event Grid Topic space to give permissions on"
}

variable "client_group_name" {
  type        = string
  description = "Name of Event Grid client group to give permissions to"
}

variable "permission_role" {
  type        = string
  description = "Permisison role should be 'Publisher' | 'Subscriber'"
}

variable "api_version" {
  type        = string
  description = "API version to use for the resource"
  default     = ""
}
