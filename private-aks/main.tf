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
  app_node_pool_name = "app"
  default_node_pool = {
    system = {
      node_pool_name           = "system"
      node_type                = "Standard_D4s_v3"
      enable_windows_node_pool = false
      min_node_count           = 1
      max_node_count           = 3
      os_sku_windows           = null
    }
  }
  validated_node_pool = try(var.node_pool["system"], null) == null ? merge(local.default_node_pool, var.node_pool) : var.node_pool
  node_pool           = var.node_pool == {} ? local.default_node_pool : local.validated_node_pool
  /* If we set enable_system_node_pool_unschedule value to true then CriticalAddonsOnly=true:NoSchedule 
  taint to prevent application pods from being scheduled on system node pools and if the value of 
  enable_system_node_pool_unschedule is false then a empty string is passed which means removing all 
  taints which is nothing but a default value.
  */
  enable_system_node_pool_unschedule = var.enable_system_node_pool_unschedule ? var.system_node_pool_taint : [""]
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
    name                        = lookup(local.node_pool["system"], "name", "system")
    temporary_name_for_rotation = "${lookup(local.node_pool["system"], "name", "system")}temp"
    vnet_subnet_id              = var.subnet_id
    vm_size                     = lookup(local.node_pool["system"], "node_type", "Standard_D4s_v3")
    enable_auto_scaling         = true
    min_count                   = lookup(local.node_pool["system"], "min_node_count", 1)
    max_count                   = lookup(local.node_pool["system"], "max_node_count", 3)
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
    network_plugin = var.network_plugin
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
      tags["GM Strictest Data Classification"],
      default_node_pool[0].only_critical_addons_enabled
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

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each              = { for k, v in local.node_pool : k => v if k != "system" }
  name                  = each.value.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vnet_subnet_id        = var.subnet_id
  vm_size               = lookup(each.value, "node_type", "Standard_D4s_v3")
  os_type               = lookup(each.value, "enable_windows_node_pool", false) == true ? "Windows" : null
  os_sku                = lookup(each.value, "os_sku_windows", null) != null ? "Windows" : null
  enable_auto_scaling   = true
  min_count             = lookup(each.value, "min_node_count", 1)
  max_count             = lookup(each.value, "min_node_count", 3)
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
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
}

resource "azapi_update_resource" "this" {
  type        = "Microsoft.ContainerService/managedClusters/agentPools@2023-04-01"
  resource_id = "${azurerm_kubernetes_cluster.this.id}/agentPools/${lookup(local.node_pool["system"], "name", "system")}"

  body = jsonencode({
    properties = {
      "nodeTaints" : local.enable_system_node_pool_unschedule

    }
  })
  depends_on = [azurerm_kubernetes_cluster.this]
}
