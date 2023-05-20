output "aks" {
  description = "AKS azurerm_kubernetes_cluster resource"
  value       = azurerm_kubernetes_cluster.this
}

output "kube_config" {
  description = "Specifies the AKS Cluster kubeconfig"
  value       = azurerm_kubernetes_cluster.this.kube_config.0
  sensitive   = true
}

output "name" {
  description = "Specifies the name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "id" {
  description = "Specifies the resource id of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "issuer_url" {
  description = "OIDC Issuer URL of the provider which allows the API server to discover public signing keys"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "aks_identity_principal_id" {
  description = "Specifies the principal id of the managed identity of the AKS cluster"
  value       = azurerm_user_assigned_identity.this.principal_id
}
