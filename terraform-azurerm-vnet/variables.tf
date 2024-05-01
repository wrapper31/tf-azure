variable "resource_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "location" {
  description = "Location of the azure resources"
  type        = string
}

variable "vnet_cidr_ranges" {
  description = "CIDR IP range for the spoke VNet"
  type        = list(string)
}

variable "tags" {
  description = "The tag name (key=value)"
  type        = map(string)
  default     = {}
}

variable "ddos_protection_plan_id" {
  description = "ID of the DDOS protection plan"
  type        = string
  default     = "/subscriptions/{uuid}/resourceGroups/{rg}/providers/Microsoft.Network/ddosProtectionPlans/a203578-p1-musea2-ddosp001"
}

variable "env" {
  description = "Name of the deployment environment"
  type        = string
}

variable "location_prefix" {
  description = "Prefix for the location of the resource eg., region code"
  type        = string
}

variable "asms" {
  description = "ASMS Number"
  type        = number
}

variable "firewall_ip_override" {
  description = "IP of the firewall to serve as a DNS server, overrides the calculated default"
  type        = string
  default     = null
}

variable "hub_resource_group_name_override" {
  description = "Name of the hub resource group, overrides the calculated default"
  type        = string
  default     = null
}

variable "hub_virtual_network_name_override" {
  description = "Name of the hub virtual network, overrides the calculated default"
  type        = string
  default     = null
}

variable "hub_route_table_name_override" {
  description = "Name of the hub route table, overrides the calculated default"
  type        = string
  default     = null
}

variable "additional_dns_vnet_info" {
  description = "Any additional hub VNets to link DNS to"
  type = map(object({
    virtual_network_name = string
    resource_group_name  = string
  }))
  default = {}
}


variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}

variable "hub_network_link_default_custom_name" {
  description = "The name of the dns zone hub network link"
  type        = string
  default     = null
}

variable "hub_network_link_custom_name" {
  description = "The name of the dns zone hub network link"
  type        = string
  default     = null
}

variable "spoke_to_hub_peering_name" {
  description = "Spoke to hub peering nanme"
  type        = string
  default     = null
}

variable "hub_to_spoke_peering_name" {
  description = "Hub to spoke peering nanme"
  type        = string
  default     = null
}

variable "devtest_environment_code_override" {
  description = "whether to override default devtest environment code"
  type        = bool
  default     = false
}