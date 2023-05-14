resource "kubernetes_service_account" "this" {
  for_each = local.service_acc_name

  metadata {
    name      = each.key
    namespace = kubernetes_namespace.this.id
    annotations = {
      "azure.workload.identity/client-id" = each.value.uami_client_id
    }
    labels = {
      "azure.workload.identity/use" : "true"
    }
  }
}

resource "azurerm_federated_identity_credential" "this" {
  for_each = local.service_acc_name

  name                = "${each.key}-fid"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.issuer_url
  parent_id           = each.value.uami_id
  subject             = "system:serviceaccount:${kubernetes_service_account.this[each.key].metadata[0].namespace}:${kubernetes_service_account.this[each.key].metadata[0].name}"
}
