variable "resource_group_name" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "resource_type" {
  type        = string
  description = "The predominant resource type in the subnet"
}

variable "descriptor" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "address_space" {
  type = string
}

variable "firewall_ip" {
  type        = string
  description = "Pass in Dev or Prod respective Firewall IP."
}

variable "private_endpoint_network_policies" {
  type        = string
  description = "GM network security mandates this parameter to be set as Enabled - https://colibri.opi.gm.com/documents/azure-cloud/networking/network-security#required-inbound-nsg-rules"
  default     = "Enabled"
}

variable "private_link_service_network_policies" {
  type        = string
  description = "GM network security mandates this parameter to be set as Enabled - https://colibri.opi.gm.com/documents/azure-cloud/networking/network-security#required-inbound-nsg-rules"
  default     = "Enabled"
}

variable "inbound_connections" {
  type = set(object({
    address_space              = string
    port_range                 = string
    destination_address_prefix = string
  }))
  default = []
}

variable "outbound_connections" {
  type = set(object({
    address_space = string
    port_range    = string
  }))
  default = []
}

variable "cidr_address_prefix" {
  type    = string
  default = "0.0.0.0/0"
}

variable "service_endpoints" {
  type    = list(any)
  default = []
}

variable "delegations" {
  type = set(object({
    name = string
    properties = object({
      serviceName = string
    })
  }))
  description = <<EOF
    Delegate subnet to a dedicated service.
    Example:
      [{
        name = "delegation"
        properties = {
          serviceName = "Microsoft.ContainerInstance/containerGroups"
        }
      }
      ]
  EOF
  default     = []
}

variable "routes" {
  type = list(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
  }))
  description = <<EOF
    Manages the routes for this subnet
    Example:
      { name = "IothubRoute",
        address_prefix = "AzureIoTHub",
        next_hop_type = "Internet"
      }]
  EOF
  default     = []
}

variable "tags" {
  type = map(string)
}

variable "enable_deny_rule" {
  type        = bool
  description = "to enable deny all rule"
  default     = true
}

variable "next_hop_is_to_vappliance" {
  type        = bool
  description = "to pass the route to firewall IP (Virtual Appliance)"
  default     = true
}

variable "appgateway_enabled" {
  type        = bool
  description = "Is App Gateway Enabled? This variable is for enabling traffic to pass through using NSG rules. By Default Traffic is denied"
  default     = false
}
