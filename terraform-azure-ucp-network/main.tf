data "azurerm_virtual_network" "tf_ucp" {
  resource_group_name = var.resource_group_name
  name                = var.virtual_network_name
}

module "service_bus_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "sb"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.service_bus_address_space
  inbound_connections = [
    {
      address_space = var.functions_address_space
      port_range    = "443"
    },
    {
      address_space = var.aks_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
}

module "event_hub_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "evhns"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.event_hub_address_space
  inbound_connections = [
    {
      address_space = var.iot_hub_address_space
      port_range    = "443"
    },
    {
      address_space = var.aks_address_space
      port_range    = "443"
    }
  ]
  outbound_connections = [
    {
      address_space = var.functions_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.service_bus_subnet
  ]
}

module "event_grid_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "eg"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.event_grid_address_space
  outbound_connections = [
    {
      address_space = var.storage_account_address_space
      port_range    = "443"
    },
    {
      address_space = var.functions_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.event_hub_subnet
  ]
}

module "iot_hub_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "ih"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.iot_hub_address_space
  inbound_connections = [
    {
      address_space = var.aks_address_space
      port_range    = "443"
    }
  ]
  outbound_connections = [
    {
      address_space = var.event_hub_address_space
      port_range    = "443"
    },
    {
      address_space = var.event_grid_address_space
      port_range    = "443"
    }
  ]
  tags       = local.tags
  depends_on = [module.event_grid_subnet]
}

module "cosmos_db_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "cosmos"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.cosmos_db_address_space
  inbound_connections = [
    {
      address_space = var.functions_address_space
      port_range    = "443"
    },
    {
      address_space = var.aks_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.iot_hub_subnet
  ]
}

module "function_apps_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "func"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.functions_address_space
  inbound_connections = [
    {
      address_space = var.event_grid_address_space
      port_range    = "443"
    },
    {
      address_space = var.event_grid_address_space
      port_range    = "443"
    }
  ]
  outbound_connections = [
    {
      address_space = var.cosmos_db_address_space
      port_range    = "443"
    },
    {
      address_space = var.service_bus_address_space
      port_range    = "443"
    },
    {
      address_space = var.aks_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.cosmos_db_subnet
  ]
}

module "aks_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.aks_address_space
  inbound_connections = [
    {
      address_space = var.functions_address_space
      port_range    = "443"
    }
  ]
  outbound_connections = [
    {
      address_space = var.iot_hub_address_space
      port_range    = "443"
    },
    {
      address_space = var.event_hub_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.function_apps_subnet
  ]
}

module "dev_portal_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "portal"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.dev_portal_address_space
  tags                = local.tags
  depends_on = [
    module.aks_subnet
  ]
}

module "storage_account_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "sa"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.storage_account_address_space
  inbound_connections = [
    {
      address_space = var.event_grid_address_space
      port_range    = "443"
    },
    {
      address_space = var.functions_address_space
      port_range    = "443"
    },
    {
      address_space = var.aks_address_space
      port_range    = "443"
    },
    {
      address_space = var.dev_portal_address_space
      port_range    = "443"
    }
  ]
  tags = local.tags
  depends_on = [
    module.dev_portal_subnet
  ]
}

module "key_vault_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "kv"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.key_vault_address_space
  service_endpoints   = [{ service = "Microsoft.KeyVault" }]
  tags                = local.tags
  depends_on = [
    module.storage_account_subnet
  ]
}

module "app_service_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "as"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.app_service_address_space
  service_endpoints   = [{ service = "Microsoft.Web" }]
  tags                = local.tags
  depends_on = [
    module.key_vault_subnet
  ]
}

module "app_gateway_subnet" {
  source              = "../terraform-azure-subnet"
  name_prefix         = var.resource_prefix
  name_suffix         = "gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = data.azurerm_virtual_network.tf_ucp.id
  address_space       = var.app_gateway_address_space
  service_endpoints   = [{ service = "Microsoft.KeyVault" }]
  cidr_address_prefix = "0.0.0.0/8"
  inbound_connections = [
    {
      address_space = "*"
      port_range    = "443"
    },
    {
      address_space = "*"
      port_range    = "65200-65535"
    }
  ]
  tags = local.tags
  depends_on = [
    module.app_service_subnet
  ]
}
