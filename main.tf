# Commenting out to skip provider registration errors for container service(Its a one time activity)
# provider "azurerm" {
#   features {}
#   skip_provider_registration = true
# }

# resource "azurerm_resource_provider_registration" "container_service" {
#   name = "Microsoft.ContainerService"

#   feature {
#     name       = "EnableWorkloadIdentityPreview"
#     registered = true
#   }
# }

locals {
  system_node_pool_name = "system"
  app_node_pool_name    = "app"
}

resource "azurerm_kubernetes_cluster" "this" {
  name                                = "${var.name_prefix}-aks-${var.descriptor}"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  node_resource_group                 = "MC_${var.name_prefix}-rg-${var.descriptor}"
  private_cluster_enabled             = var.private
  private_cluster_public_fqdn_enabled = true
  dns_prefix                          = "${var.name_prefix}-aks-${var.descriptor}"
  private_dns_zone_id                 = var.private ? "None" : null
  oidc_issuer_enabled                 = true
  workload_identity_enabled           = true
  azure_policy_enabled                = true
  http_application_routing_enabled    = false
  role_based_access_control_enabled   = true


  default_node_pool {
    name                        = local.system_node_pool_name
    temporary_name_for_rotation = "${local.system_node_pool_name}temp"
    vnet_subnet_id              = var.subnet_id
    vm_size                     = var.node_type_system
    enable_auto_scaling         = true
    min_count                   = var.min_node_count_system
    max_count                   = var.max_node_count_system

  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  //enabled keyvault secret provider secret rotation
  key_vault_secrets_provider {
    secret_rotation_enabled = var.csi_driver_enabled
  }

  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway.enabled == true ? [1] : []
    content {
      gateway_id = var.ingress_application_gateway.gateway_id
    }
  }

  dynamic "oms_agent" {
    for_each = var.enable_diagnostics ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_resource_id
    }
  }

  network_profile {
    network_plugin = var.enable_windows_node_pool ? "azure" : var.network_plugin
    outbound_type  = var.outbound_type

  }

  depends_on = [
    azurerm_role_assignment.network_contributor_vnet_rg,
    azurerm_role_assignment.network_contributor_rg
  ]

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = local.app_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vnet_subnet_id        = var.subnet_id
  vm_size               = var.node_type_app
  os_type               = var.enable_windows_node_pool ? "Windows" : null
  os_sku                = var.enable_windows_node_pool ? var.os_sku_windows : null
  enable_auto_scaling   = true
  min_count             = var.min_node_count_app
  max_count             = var.max_node_count_app
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_kubernetes_cluster.this.name, "diag"))
  target_resource_id         = azurerm_kubernetes_cluster.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_logs

    content {
      category = enabled_log.value.category

      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
