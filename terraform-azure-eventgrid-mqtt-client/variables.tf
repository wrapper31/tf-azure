variable "name" {
  description = "Client Name in the MQTT Namespace"
  type        = string
}

variable "mqtt_broker_namespace_id" {
  description = "Resource ID of the MQTT broker namespace"
  type        = string
}


variable "description" {
  type        = string
  description = "Description of the client"
  default     = ""
}

variable "certificate_subject" {
  type = object({
    commonName         = string
    organization       = optional(string)
    organizationalUnit = optional(string)
    locality           = optional(string)
    province           = optional(string)
    countryCode        = optional(string)
  })
  description = "Certificate subject to match against this client"
}

variable "attributes" {
  type        = map(any)
  description = "Client Attributes"
}

variable "state" {
  type        = string
  default     = "Enabled"
  description = "The state of the client"
  validation {
    condition     = contains(["Enabled", "Disabled"], var.state)
    error_message = "State must be one of Enabled or Disabled"
  }
}

variable "api_version" {
  type        = string
  description = "API version to use for the resource"
  default     = ""
}
