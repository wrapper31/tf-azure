
provider "kubernetes" {
  host                   = var.kube_config.host
  client_key             = base64decode(var.kube_config.client_key)
  client_certificate     = base64decode(var.kube_config.client_certificate)
  cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
}
