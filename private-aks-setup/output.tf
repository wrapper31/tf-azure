data "kubernetes_service" "this" {
  count = var.ingress_enabled ? 1 : 0

  metadata {
    name      = "${helm_release.ingress[0].name}-${helm_release.ingress[0].chart}-controller"
    namespace = kubernetes_namespace.this.id
  }
}

output "ingress_ip" {
  description = "IP address of ingress controller service"
  value       = var.ingress_enabled ? data.kubernetes_service.this[0].status[0].load_balancer[0].ingress[0].ip : null
}

output "namespace" {
  description = "Namespace created in the cluster and used for system components"
  value       = kubernetes_namespace.this.id
}

output "tls_secret" {
  description = "Name of the secret containing the TLS certificate for the ingress"
  value       = local.csi_secret_name
}
