variable "private_dns_zone_name" {
  type        = string
  description = "Name of the private dns zone"

}

variable "dns_resource_group_name" {
  type        = string
  description = "Name of the DNS resource group"
}
variable "env" {
  type        = string
  description = "Name of the deployment environment"
}

variable "nginx_ingress_ip" {
  type        = string
  description = "Nginx ingress IP"
}
variable "hostnames" {
  type        = list(string)
  description = "Nginx ingress IP"

}
variable "microservices_dns_ttl" {
  type        = string
  description = "Time to live setting for A record for pods"

}
