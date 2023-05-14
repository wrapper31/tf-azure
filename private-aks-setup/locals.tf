locals {
  csi_secret_provider_class_name = "azure-tls"
  csi_secret_name                = "ingress-tls-csi"
  csi_service_account_name       = "csi-sa"
  ingress_class_name             = "nginx"
  workload_identities = setunion(var.workload_identity, var.ingress_enabled ? [{
    uami_id         = azurerm_user_assigned_identity.csi_driver[0].id
    uami_client_id  = azurerm_user_assigned_identity.csi_driver[0].client_id
    service_ac_name = local.csi_service_account_name
  }] : [])
  service_acc_name = { for sa in local.workload_identities : sa.service_ac_name => sa }
}
