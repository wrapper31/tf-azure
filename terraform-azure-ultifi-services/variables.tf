variable "hostname" {
  type        = string
  description = "Host name for the each microservice"
}

variable "kube_config" {
  type = object({
    host                   = string
    client_key             = string
    client_certificate     = string
    cluster_ca_certificate = string
  })
  description = "Kubernetes Kube config details"
}
