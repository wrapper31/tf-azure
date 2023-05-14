variable "resource_group_name" {
  description = "Name of the resource group"
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
  description = "The location where resources need to be build"
  type        = string
}

variable "tags" {
  description = "The tag name (key=value)"
  type        = map(string)
  default     = {}
}

variable "namespace" {
  description = "Namespace to be created in the cluster and used for system components"
  type        = string
  default     = "main"
}

variable "app_insights_connection_string" {
  description = "Connection string for Application Insights instance to pass along for services to write traces to"
  type        = string
  sensitive   = true
  default     = null
}

variable "issuer_url" {
  description = "OIDC Issuer URL of the provider which allows the API server to discover public signing keys"
  type        = string
  default     = null
}

variable "workload_identity" {
  description = "Workload identity id, client id and service account name"
  type = set(object({
    uami_id         = string
    uami_client_id  = string
    service_ac_name = string
  }))
  default = []
}

variable "ingress_enabled" {
  description = "Whether or not the ingress controller should be deployed"
  type        = bool
  default     = false
}

variable "ingress_key_vault_name" {
  description = "Name of the key vault where the ingress certificate is stored"
  type        = string
  default     = null
}

variable "ingress_key_vault_id" {
  description = "ID of the key vault where the ingress certificate is stored"
  type        = string
  default     = null
}

variable "ingress_certificate_name" {
  description = "Name of the certificate to be used by the ingress"
  type        = string
  default     = null
}

variable "ingress_chart_version" {
  description = "Version of the ingress helm chart to be deployed"
  type        = string
  default     = "4.5.2"
}

variable "ingress_replica_count" {
  description = "Number of replicas to be deployed for the ingress controller"
  type        = number
  default     = 2
}

variable "system_node_pool" {
  description = "Name of the node pool to deploy system resources such as ingress controller"
  type        = string
  default     = "system"
}

variable "ingress_private_endpoint_enabled" {
  description = "Whether or not the ingress controller should be deployed with a private endpoint"
  type        = bool
  default     = true
}

variable "hostname_prefix" {
  description = "Prefix Hostname for AKS. For example aksdpt for devportal"
  type        = string
  default     = null
}

variable "dns_zone_name" {
  description = "Private DNS zone name (Set usually in Terragrunt)"
  type        = string
  default     = null
}

variable "dns_zone_resource_group" {
  description = "private DNS zone Resource Group Name. (Set usually in Terragrunt)"
  type        = string
  default     = null
}
