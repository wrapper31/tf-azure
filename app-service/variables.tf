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

variable "inbound_subnet_id" {
  description = "The ID of the subnet for the private endpoint to be placed in"
  type        = string
}
variable "outbound_subnet_id" {
  description = "The ID of the outbound subnet for the Vnet Integration"
  type        = string
}

variable "worker_count" {
  description = "The number of Workers for this Linux App Service"
  type        = number
  default     = 1
}

variable "custom_domain_hostname" {
  description = "Custom hostname for the Application Service"
  type        = string
  default     = null
}

variable "key_vault_id" {
  description = "The ID of the key vault containing the certificate for the custom hostname"
  type        = string
  default     = null
}

variable "certificate_name" {
  description = "The name of the certificate for the custom hostname"
  type        = string
  default     = null
}

variable "certificate_secret_id" {
  description = "The secret ID of the certificate for the custom hostname"
  type        = string
  default     = null
}

variable "tags" {
  description = "The tag name (key=value)"
  type        = map(any)
}

variable "app_settings" {
  description = "Map of app settings to be passed to the Application Service"
  type        = map(string)
  default     = {}
}

variable "read_azure_app_service_principal_id" {
  description = "Whether to read the ID of the Microsoft Azure App Service SP from AD dynamically"
  type        = bool
  default     = true
}

variable "azure_app_service_principal_id" {
  description = "The ID of the Microsoft Azure App Service SP in the tenant in case it is not read dynamically, the default is for the GM tenant"
  type        = string
  default     = "cb630454-7874-43b8-bf32-65bd6d222095"
}

variable "auth_settings" {
  description = "Authentication settings. Issuer URL is generated thanks to the tenant ID. For active_directory block, the allowed_audiences list is filled with a value generated with the name of the App Service. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#auth_settings"
  type        = any
  default     = {}
}

variable "application_stack" {
  description = "application stack for app service"
  type        = map(string)
  default     = { node_version = "16-lts" }
}

variable "node_version" {
  description = "Node Version"
  type        = string
  default     = null
}

variable "svc_plan_id" {
  description = "Get App Service Plan ID"
  type        = string
}

variable "always_on" {
  description = "Should App Service be Always ON?"
  type        = bool
  default     = true
}

variable "python_version" {
  description = "Python Version"
  type        = string
  default     = null
}

variable "ip_restriction" {
  description = "GM IP range restriction"
  type = set(object({
    name                      = string
    priority                  = number
    ip_address                = string
    virtual_network_subnet_id = string
    service_tag               = string

  }))
  default = [{
    name                      = "GM_Network_Access"
    priority                  = 600
    action                    = "Allow"
    ip_address                = "198.208.0.0/16"
    virtual_network_subnet_id = null
    service_tag               = null
  }]

}
