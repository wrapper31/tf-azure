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

variable "templates" {
  type        = list(string)
  description = "List of template topic filters defining the topic space"
}

variable "subscription_support" {
  type        = string
  description = "subscription support"
}

variable "api_version" {
  type        = string
  description = "API version to use for the resource"
  default     = ""
}
