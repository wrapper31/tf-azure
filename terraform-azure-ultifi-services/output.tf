output "load_balancer_hostname" {
  description = "load balancer hostname- output to oher module subsystems"
  value       = kubernetes_ingress_v1.ucptest.status.0.load_balancer.0.ingress.0.hostname
}

output "load_balancer_ip" {
  description = "Display load balancer IP (typically present in GCP, or using Nginx ingress controller)"
  value       = kubernetes_ingress_v1.ucptest.status.0.load_balancer.0.ingress.0.ip
}
