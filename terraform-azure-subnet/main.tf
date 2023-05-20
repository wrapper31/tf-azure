resource "azurerm_network_security_group" "this" {
  name                = "${var.name_prefix}-nsg-${var.resource_type}-${var.descriptor}"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "AllowGMNonAzureNetworkInBound"
    priority                   = 250
    direction                  = "Inbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = local.gm_edc_tools_ips
    destination_address_prefix = "*"
    access                     = "Allow"
  }

  security_rule {
    name                       = "AllowGMAzureToolsInBound"
    priority                   = 251
    direction                  = "Inbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = local.gm_azure_tools_ips
    destination_address_prefix = "*"
    access                     = "Allow"
  }
  security_rule {
    name                       = "AllowBastionInBound"
    priority                   = 252
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [22, 3389]
    source_address_prefixes    = local.gm_hub_bastion_ips
    destination_address_prefix = "*"
    access                     = "Allow"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 3750
    direction                  = "Inbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
    access                     = "Allow"
  }

  security_rule {
    name                       = "DenyVnetInBound"
    priority                   = 4096
    direction                  = "Inbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    access                     = "Deny"
  }

  security_rule {
    name                       = "DenyDMZToDBOutBound"
    priority                   = 4095
    direction                  = "Outbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [1433, 5432]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = var.appgateway_enabled ? "Allow" : "Deny"
  }

  # Inbound rules
  dynamic "security_rule" {
    for_each = zipmap(range(length(var.inbound_connections)), tolist(var.inbound_connections))
    content {
      name                       = "AllowSubnet${security_rule.key}Inbound"
      priority                   = 601 + security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port_range
      source_address_prefix      = security_rule.value.address_space
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  # Outbound rules
  dynamic "security_rule" {
    for_each = zipmap(range(length(var.outbound_connections)), tolist(var.outbound_connections))
    content {
      name                       = "AllowSubnet${security_rule.key}Outbound"
      priority                   = 601 + security_rule.key
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port_range
      source_address_prefix      = "*"
      destination_address_prefix = security_rule.value.address_space
    }
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

resource "azurerm_route_table" "this" {
  name                          = "${var.name_prefix}-rt-${var.resource_type}-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true

  dynamic "route" {
    for_each = var.next_hop_is_to_vappliance ? [1] : []
    content {
      name                   = "firewallRoute"
      address_prefix         = var.cidr_address_prefix
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.firewall_ip
    }
  }

  dynamic "route" {
    for_each = var.next_hop_is_to_vappliance ? [] : [1]
    content {
      name           = "InternetRoute"
      address_prefix = var.cidr_address_prefix
      next_hop_type  = "Internet"

    }
  }

  dynamic "route" {
    for_each = var.routes
    iterator = item
    content {
      name           = item.value.name
      address_prefix = item.value.address_prefix
      next_hop_type  = item.value.next_hop_type
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      route,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azapi_resource" "subnet" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2021-08-01"
  name      = "${var.name_prefix}-snet-${var.resource_type}-${var.descriptor}"
  parent_id = var.virtual_network_id
  body = jsonencode({
    properties = {
      delegations   = var.delegations
      addressPrefix = var.address_space
      networkSecurityGroup = {
        id = azurerm_network_security_group.this.id
      }
      serviceEndpoints = var.service_endpoints
      routeTable = {
        id = azurerm_route_table.this.id
      }
      privateEndpointNetworkPolicies    = var.private_endpoint_network_policies
      privateLinkServiceNetworkPolicies = var.private_link_service_network_policies
    }
  })
}
