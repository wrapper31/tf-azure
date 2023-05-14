resource "helm_release" "ingress" {
  count = var.ingress_enabled ? 1 : 0

  name       = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.ingress_chart_version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/ingress-controller.yaml", {
      service_account_name           = local.csi_service_account_name
      replica_count                  = var.ingress_replica_count
      node_pool                      = var.system_node_pool
      ingress_class_name             = local.ingress_class_name
      internal_load_balancer_enabled = var.ingress_private_endpoint_enabled
      secret_provider_class_name     = kubectl_manifest.secret_provider_class[0].name
    })
  ]
}

resource "azurerm_private_dns_a_record" "this" {
  count               = var.ingress_enabled ? 1 : 0
  name                = var.hostname_prefix
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
  ttl                 = 300
  records             = [data.kubernetes_service.this[0].status[0].load_balancer[0].ingress[0].ip]
  depends_on = [
    data.kubernetes_service.this
  ]
}
