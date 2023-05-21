module "event_hub_vsu" {
  source                    = "../terraform-azure-event-hub"
  resource_group_name       = var.resource_group_name
  sku                       = "Standard"
  location                  = var.location
  subnet_id                 = var.event_hub_subnet_id
  resource_prefix           = var.resource_prefix
  descriptor                = "vsu"
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  event_hub = [
    {
      name              = "c2dsub",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "c2dsub-rule"
        listen = true
        send   = true
        manage = false
      }
    },
    {
      name              = "d2cpub",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "d2cpub-rule"
        listen = true
        send   = true
        manage = false
      }
    },
    {
      name              = "d2csta",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "d2csta-rule"
        listen = true
        send   = true
        manage = false
      }
    }
  ]
  tags = local.tags
}

module "eh_cg_vsu" {
  source              = "../terraform-azure-eventhub-consumergroup"
  resource_group_name = var.resource_group_name
  event_hub_namespace = module.event_hub_vsu.eventhub_namespace
  event_hub_name      = module.event_hub_vsu.eventhub_names[0]
  consumer_groups     = ["rs-c2d-consumer"]
  tags                = local.tags
}

module "event_hub_asu" {
  source                    = "../terraform-azure-event-hub"
  resource_group_name       = var.resource_group_name
  resource_prefix           = var.resource_prefix
  descriptor                = "asu"
  sku                       = "Standard"
  location                  = var.location
  subnet_id                 = var.event_hub_subnet_id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  event_hub = [
    {
      name              = "d2cpub",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "d2cpub-rule"
        listen = true
        send   = true
        manage = false
      }
    },
    {
      name              = "d2csta",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "d2csta-rule"
        listen = true
        send   = true
        manage = false
      }
    }
  ]
  tags = local.tags
}

module "eh_cg_asu" {
  source              = "../terraform-azure-eventhub-consumergroup"
  resource_group_name = var.resource_group_name
  event_hub_namespace = module.event_hub_asu.eventhub_namespace
  event_hub_name      = module.event_hub_asu.eventhub_names[0]
  consumer_groups     = ["rs-d2c-consumer"]
  tags                = local.tags
}

module "event_hub_apps" {
  source                    = "../terraform-azure-event-hub"
  resource_group_name       = var.resource_group_name
  resource_prefix           = var.resource_prefix
  sku                       = "Standard"
  descriptor                = "apps"
  location                  = var.location
  subnet_id                 = var.event_hub_subnet_id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  event_hub = [
    {
      name              = "cat001",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "cat001-rule"
        listen = true
        send   = true
        manage = false
      }
    },
    {
      name              = "cat002",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "cat002-rule"
        listen = true
        send   = true
        manage = false
      }
    }
  ]
  tags = local.tags
}

module "eh_cg_apps" {
  source              = "../terraform-azure-eventhub-consumergroup"
  resource_group_name = var.resource_group_name
  event_hub_namespace = module.event_hub_apps.eventhub_namespace
  event_hub_name      = module.event_hub_apps.eventhub_names[0]
  consumer_groups     = ["rs-cat-consumer"]
  tags                = local.tags
}

module "event_hub_dms" {
  source                    = "../terraform-azure-event-hub"
  resource_group_name       = var.resource_group_name
  resource_prefix           = var.resource_prefix
  sku                       = "Standard"
  descriptor                = "dms"
  location                  = var.location
  subnet_id                 = var.event_hub_subnet_id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  event_hub = [
    {
      name              = "dms001",
      partitions        = 2,
      message_retention = 1
      authorization = {
        name   = "dms001-rule"
        listen = true
        send   = true
        manage = false
      }
    }
  ]
  tags = local.tags
}

module "function_app" {
  source               = "../terraform-azure-function-apps"
  resource_group_name  = var.resource_group_name
  resource_group_id    = var.resource_group_id
  name_prefix          = var.resource_prefix
  name_prefix_no_dash  = var.resource_prefix_no_dash
  descriptor           = "dmsfn"
  location             = var.location
  subnet_id            = var.function_apps_subnet_id
  service_plan_id      = var.service_plan_id
  storage_account_name = var.storage_account_name
  outbound_subnet_id   = ""
  app_settings = {
    EventGridBufferConnectionString = module.event_hub_dms.authorization_rules["dms001"].primary_connection_string
  }
  app_insights_name                = module.app_insights.name
  app_insights_resource_group_name = module.app_insights.rg_name
  tags                             = local.tags
}

module "iot_hub" {
  source                           = "../terraform-azure-iot-hub"
  resource_group_name              = var.resource_group_name
  name_prefix                      = var.resource_prefix
  descriptor                       = "main"
  location                         = var.location
  subnet_id                        = var.iot_hub_subnet_id
  pubnet_access_enabled            = local.pubnet_access_enabled
  pvtnet_access_enabled            = local.pvtnet_access_enabled
  netrule_default_action           = "Allow" #Allow/Deny
  netrule_to_builtin_evnthub_endpt = false
  iprule_ipmask                    = "198.208.47.0/24"
  iprule_action                    = "Allow" #Allow/Deny
  dps_name                         = module.dps.dps_name
  resource_group_id                = var.resource_group_id
  enable_diagnostics               = true
  log_analytics_resource_id        = module.log_analytics.id
  eventhub_namespace_vsu_id        = module.event_hub_vsu.eventhub_namespace_id
  event_hub_routes = [
    {
      condition = "$body.type = 'pub.v1'"
      endpoint  = module.event_hub_vsu.eventhubs["d2cpub"]
    },
    {
      condition = "$body.type = 'stat.v1'"
      endpoint  = module.event_hub_vsu.eventhubs["d2csta"]
    }
  ]
  event_grid_subscriptions = {
    dms = {
      event_types = [
        "Microsoft.Devices.DeviceCreated",
        "Microsoft.Devices.DeviceDeleted",
        "Microsoft.Devices.DeviceConnected",
        "Microsoft.Devices.DeviceDisconnected"
      ]
      event_hub_id = module.event_hub_dms.eventhub_id.0
    }
  }
  tags = local.tags
}


module "iot_hub2" {
  source                           = "../terraform-azure-iot-hub"
  resource_group_name              = var.resource_group_name
  name_prefix                      = var.resource_prefix
  descriptor                       = "main2"
  location                         = var.location
  subnet_id                        = var.iot_hub_subnet_id
  pubnet_access_enabled            = local.pubnet_access_enabled
  pvtnet_access_enabled            = local.pvtnet_access_enabled
  netrule_default_action           = "Allow" #Allow/Deny
  netrule_to_builtin_evnthub_endpt = false
  iprule_ipmask                    = "198.208.47.0/24"
  iprule_action                    = "Allow" #Allow/Deny
  dps_name                         = module.dps.dps_name
  resource_group_id                = var.resource_group_id
  enable_diagnostics               = true
  log_analytics_resource_id        = module.log_analytics.id
  eventhub_namespace_vsu_id        = module.event_hub_vsu.eventhub_namespace_id
  event_hub_routes = [
    {
      condition = "$body.type = 'pub.v1'"
      endpoint  = module.event_hub_vsu.eventhubs["d2cpub"]
    },
    {
      condition = "$body.type = 'stat.v1'"
      endpoint  = module.event_hub_vsu.eventhubs["d2csta"]
    }
  ]
  # function_app_routes = [
  #   {
  #     event_types = [
  #       "Microsoft.Devices.DeviceCreated",
  #       "Microsoft.Devices.DeviceDeleted",
  #       "Microsoft.Devices.DeviceConnected",
  #       "Microsoft.Devices.DeviceDisconnected"
  #     ]
  #     id = module.function_app.function_id
  #   }
  # ]
  tags = local.tags
}

###################### Add shared access policy resources based on no of IOT Hubs #####################

resource "azurerm_iothub_shared_access_policy" "tf_ucp_policy1" {
  name                = "iotdpssap"
  resource_group_name = var.resource_group_name
  iothub_name         = module.iot_hub.name
  registry_read       = true
  registry_write      = true
  service_connect     = true
  device_connect      = true
}

resource "azurerm_iothub_shared_access_policy" "tf_ucp_policy2" {
  name                = "iotdpssap"
  resource_group_name = var.resource_group_name
  iothub_name         = module.iot_hub2.name
  registry_read       = true
  registry_write      = true
  service_connect     = true
  device_connect      = true
}

######################## Add connection string block in IOTHUBS based on no of IOT Hub resources #########################

resource "azapi_update_resource" "linked_hub" {
  type      = "Microsoft.Devices/provisioningServices@2022-02-05"
  name      = module.dps.dps_name
  parent_id = var.resource_group_id


  body = jsonencode({
    properties = {
      iotHubs = [{
        connectionString = azurerm_iothub_shared_access_policy.tf_ucp_policy1.primary_connection_string
        location         = var.location
        },
        {
          connectionString = azurerm_iothub_shared_access_policy.tf_ucp_policy2.primary_connection_string
          location         = var.location
        }
      ]
    }
  })
}


module "dps" {
  source                    = "../terraform-azure-dps"
  resource_group_name       = var.resource_group_name
  name_prefix               = var.resource_prefix
  descriptor                = "main"
  location                  = var.location
  allocation_policy         = "GeoLatency"
  subnet_id                 = var.iot_hub_subnet_id
  device_root_cert          = filebase64("../terraform-azure-dps/RootCA.pem")
  pubnet_access_enabled     = local.pubnet_access_enabled
  pvtnet_access_enabled     = local.pvtnet_access_enabled
  ip_filter_rule_ip_mask    = "0.0.0.0"
  ip_filter_rule_action     = "Accept" #Accept/Reject
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  tags                      = local.tags
}

module "cosmos_db" {
  source                    = "../terraform-azure-cosmos-db"
  resource_group_name       = var.resource_group_name
  name_prefix               = var.resource_prefix
  descriptor                = "main"
  location                  = var.location
  subnet_id                 = var.cosmos_db_subnet_id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  tags                      = local.tags
  databases = [
    {
      name = "${var.resource_prefix}-cosmos-sql-main"
      containers = {
        "dms_device_details" = {
          partition_key_path = "/uDeviceId"
          unique_keys        = ["/uDeviceId"]
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "dms_device_connections" = {
          partition_key_path = "/uDeviceId"
          unique_keys        = []
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "dms_dps_metrics" = {
          partition_key_path = "/idScope"
          unique_keys        = ["/idScope"]
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "dms_dps_instances" = {
          partition_key_path = "/idScope"
          unique_keys        = ["/idScope"]
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "device_topics_subscriptions" = {
          partition_key_path = "/sourceDomainId"
          unique_keys        = []
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "bo_topics_subscriptions" = {
          partition_key_path = "/sinkDomainId"
          unique_keys        = []
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "apps_services_config" = {
          partition_key_path = "/boIdentifier"
          unique_keys        = []
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
        "apps_delivery_endpoint" = {
          partition_key_path = "/deliveryEndpointId"
          unique_keys        = []
          indexing_mode      = "none"
          included_paths     = []
          excluded_paths     = []
          default_timetolive = -1
        }
      }
    }
  ]
}

module "log_analytics" {
  source              = "../terraform-azure-log-analytics"
  resource_group_name = var.resource_group_name
  location            = var.location
  descriptor          = "main"
  name_prefix         = var.resource_prefix
  tags                = local.tags
  enable_diagnostics  = false
}

module "app_insights" {
  source                    = "../terraform-azure-app-insights"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  descriptor                = "main"
  name_prefix               = var.resource_prefix
  tags                      = local.tags
  log_analytics_resource_id = module.log_analytics.id
}

resource "azurerm_monitor_action_group" "dev_group" {
  name                = "dev-actiongroup"
  resource_group_name = var.resource_group_name
  short_name          = "devact"

  email_receiver {
    name                    = "email_devs"
    email_address           = "devops@gm.com"
    use_common_alert_schema = true
  }
}

module "azure_query_alert" {
  source              = "../terraform-azure-query-alert"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = module.app_insights.id
  action_group_ids    = [azurerm_monitor_action_group.dev_group.id]
  monitorci           = "MonitorCIdummy"
  # Example query to just count all logged exceptions within the time windows
  tags = local.tags
}

module "azure_metric_alert" {
  source              = "../terraform-azure-metric-alert"
  resource_group_name = var.resource_group_name
  name_prefix         = var.resource_prefix
  target_resource_id  = module.iot_hub.id
  action_group_ids    = [azurerm_monitor_action_group.dev_group.id]
  tags                = local.tags
}

module "azure_health_alert" {
  source              = "../terraform-azure-resource-health-alert"
  resource_group_name = var.resource_group_name
  descriptor          = "main"
  name_prefix         = var.resource_prefix
  target_resource_id  = var.resource_group_id
  action_group_ids    = [azurerm_monitor_action_group.dev_group.id]
  tags                = local.tags
}

module "acr" {
  source                    = "../terraform-azure-acr"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  descriptor                = "main"
  name_prefix               = var.resource_prefix
  name_prefix_no_dash       = var.resource_prefix_no_dash
  log_analytics_resource_id = module.log_analytics.id
  subnet_id                 = var.aks_subnet_id
  tags                      = local.tags
}

module "aks" {
  source                    = "../terraform-azurerm-aks"
  resource_group_name       = var.resource_group_name
  resource_group_id         = var.resource_group_id
  virtual_network_rg_id     = var.resource_group_id
  name_prefix               = var.resource_prefix
  descriptor                = "main"
  location                  = var.location
  subnet_id                 = var.aks_subnet_id
  acr_id                    = module.acr.id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  tags                      = local.tags
}

module "aks_setup" {
  app_insights_connection_string = module.app_insights.connection_string
  source                         = "../terraform-kubernetes-setup"
  resource_group_name            = var.resource_group_name
  location                       = var.location
  name_prefix                    = var.resource_prefix
  descriptor                     = "main"
  issuer_url                     = module.aks.issuer_url
  ingress_enabled                = false
  tags                           = local.tags
}

module "aks_private_dns_a_record" {
  source                  = "../terraform-azure-ucp-private-dns-a-record"
  dns_resource_group_name = var.resource_group_name
  env                     = "test"
  nginx_ingress_ip        = module.aks_setup.ingress_ip
  private_dns_zone_name   = "test-dns"
  microservices_dns_ttl   = "300"
  hostnames = [
    "rs-aks",
    "test-aks"
  ]
}

resource "azurerm_key_vault_certificate" "developer" {
  name         = "developer-${var.env}"
  key_vault_id = var.key_vault_id
  certificate {
    contents = filebase64("${path.module}/www_developer_${var.env}_ultifi_azure_ext_gm_com.pfx")
  }
}

module "aks_vm" {
  source                     = "../terraform-azure-linux-vm"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  descriptor                 = "linux"
  name_prefix                = var.resource_prefix
  name_prefix_no_dash        = var.resource_prefix_no_dash
  subnet_id                  = var.aks_subnet_id
  key_vault_private_key_name = "vmprivatekey"
  key_vault_public_key_name  = "vmpublickey"
  key_vault_openssh_name     = "vmsshkey"
  key_vault_id               = var.key_vault_id
  key_vault_name             = var.key_vault_name
  tags                       = local.tags
}
module "app_service" {
  source                 = "../terraform-azure-app-service"
  resource_group_name    = var.resource_group_name
  name_prefix            = var.resource_prefix
  descriptor             = "devportal"
  location               = var.location
  inbound_subnet_id      = var.app_service_subnet_id
  outbound_subnet_id     = var.app_service_subnet_id
  svc_plan_id            = module.appservice_plan.app_service_plan_id
  node_version           = "16-lts"
  key_vault_id           = var.key_vault_id
  certificate_name       = azurerm_key_vault_certificate.developer.name
  certificate_secret_id  = azurerm_key_vault_certificate.developer.secret_id
  custom_domain_hostname = "www.developer.${var.env}.ultifi.azure.ext.gm.com"
  tags                   = local.tags
}

module "appservice_plan" {
  source                = "../terraform-azure-app-service-plan"
  resource_group_name   = var.resource_group_name
  name_prefix           = var.resource_prefix
  descriptor            = "devportal"
  app_svc_plan_sku_name = "P3v3"
  location              = var.location
  tags                  = local.tags
}

module "application_gateway" {
  source                    = "../terraform-azure-application-gateway"
  resource_group_name       = var.resource_group_name
  name_prefix               = var.resource_prefix
  descriptor                = "main"
  location                  = var.location
  subnet_id                 = var.app_gateway_subnet_id
  key_vault_id              = var.key_vault_id
  enable_diagnostics        = true
  log_analytics_resource_id = module.log_analytics.id
  sku_public_ip             = "Standard"
  sku_public_ip_tier        = "Regional"

  sku = {
    tier = "WAF_v2",
    size = "WAF_v2"
  }
  autoscale_configuration = {
    min_capacity = "2",
    max_capacity = "4"
  }
  backend_address_pools = [{
    name = "AppGW-main-be-addrpool",
    fqdn = module.app_service.hostname
  }]
  backend_http_settings = [{
    name       = "AppGW-main-be-https",
    probe_name = "AppGW-main-healthcheck"
  }]
  probes = [{
    name = "AppGW-main-healthcheck"
    host = module.app_service.hostname
  }]
  frontend_port = [{
    name = "AppGW-main-port-443",
    port = "443"
  }]
  ssl_certificates = {
    "cert" = {
      name      = "cert"
      secret_id = "secret"
    }
  }
  http_listeners = [{
    name                      = "AppGW-main-listener-ext-https",
    frontend_ip_configuration = "Public",
    portname                  = "AppGW-main-port-443",
    protocol                  = "Https",
    hostname                  = "www.developer.${var.env}.ultifi.azure.ext.gm.com",
    ssl_certificate_name      = "cert"
  }]
  request_routing_rules = [{
    name                       = "AppGW-main-rrr-1"
    priority                   = 10
    http_listener_name         = "AppGW-main-listener-ext-https"
    backend_address_pool_name  = "AppGW-main-be-addrpool"
    backend_http_settings_name = "AppGW-main-be-https"
  }]
  tags = local.tags
}

module "mqtt_broker" {
  source                    = "../terraform-azure-eventgrid-mqtt"
  resource_group_name       = var.resource_group_name
  resource_group_id         = var.resource_group_id
  name_prefix               = var.resource_prefix
  log_analytics_resource_id = module.log_analytics.id
  descriptor                = "test-mqtt"
  location                  = var.location
  client_certs              = ["-----BEGIN CERTIFICATE-----\nfoo\n-----END CERTIFICATE-----", "-----BEGIN CERTIFICATE-----\nbar\n-----END CERTIFICATE-----"]
  tags                      = local.tags
}
