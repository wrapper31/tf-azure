locals {
  default_app_settings = {
    "minTlsVersion" = "1.2"
  }
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.name_prefix}-app-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  #service_plan_id           = azurerm_service_plan.this.id
  service_plan_id           = var.svc_plan_id
  virtual_network_subnet_id = var.outbound_subnet_id
  https_only                = true
  site_config {
    vnet_route_all_enabled = true
    worker_count           = var.worker_count
    always_on              = var.always_on
    http2_enabled          = true
    application_stack {
      node_version   = var.node_version
      python_version = var.python_version
    }
    dynamic "ip_restriction" {
      for_each = var.ip_restriction
      content {
        name                      = ip_restriction.value["name"]
        action                    = "Allow"
        priority                  = ip_restriction.value["priority"]
        ip_address                = ip_restriction.value["ip_address"]
        service_tag               = ip_restriction.value["service_tag"]
        virtual_network_subnet_id = ip_restriction.value["virtual_network_subnet_id"]
        headers                   = null
      }
    }
  }


  app_settings = merge(local.default_app_settings, var.app_settings)

  auth_settings {
    enabled                       = local.auth_settings.enabled
    issuer                        = local.auth_settings.issuer
    token_store_enabled           = local.auth_settings.token_store_enabled
    unauthenticated_client_action = local.auth_settings.unauthenticated_client_action
    default_provider              = local.auth_settings.default_provider
    #allowed_external_redirect_urls = local.auth_settings.allowed_external_redirect_urls

    dynamic "active_directory" {
      for_each = local.auth_settings_active_directory.client_id == null ? [] : [local.auth_settings_active_directory]
      content {
        client_id = local.auth_settings_active_directory.client_id
        //client_secret     = local.auth_settings_active_directory.client_secret
        //allowed_audiences = []
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
