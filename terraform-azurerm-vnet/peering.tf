data "azurerm_virtual_network" "hub" {
  provider = azurerm.hub

  name                = local.hub_virtual_network_name
  resource_group_name = local.hub_resource_group_name
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = var.spoke_to_hub_peering_name == null ? "${var.resource_prefix}-sthpeer" : var.spoke_to_hub_peering_name
  resource_group_name          = azurerm_resource_group.this.name
  virtual_network_name         = azurerm_virtual_network.this.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub.id
  use_remote_gateways          = true
  allow_gateway_transit        = false
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider = azurerm.hub

  name                         = var.hub_to_spoke_peering_name == null ? "${azurerm_virtual_network.this.name}-peer" : var.hub_to_spoke_peering_name
  resource_group_name          = data.azurerm_virtual_network.hub.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.this.id
  use_remote_gateways          = false
  allow_gateway_transit        = true
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_route" "hub" {
  for_each = zipmap(toset(var.vnet_cidr_ranges), range(length(var.vnet_cidr_ranges)))
  provider = azurerm.hub

  name                   = "${azurerm_virtual_network.this.name}-${each.value}"
  resource_group_name    = local.hub_resource_group_name
  route_table_name       = local.hub_route_table_name
  address_prefix         = each.key
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = local.firewall_ip
}