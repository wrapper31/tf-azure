resource "azurerm_private_dns_zone" "this" {
  name                = local.private_dns_zone_name
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["ASMS No"],
      tags["Business Criticality"],
      tags["Strictest Data Classification"],
      tags["Digital Asset Valuation"]
    ]
  }
}

data "azurerm_virtual_network" "hub_dns" {
  for_each = local.dns_vnet_info

  provider            = azurerm.hub
  name                = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  for_each = data.azurerm_virtual_network.hub_dns

  name                  = each.key
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = azurerm_private_dns_zone.this.resource_group_name
  virtual_network_id    = each.value.id
  tags                  = var.tags

  lifecycle {
    ignore_changes = [
      tags["ASMS No"],
      tags["Business Criticality"],
      tags["Strictest Data Classification"],
      tags["Digital Asset Valuation"]
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke" {
  name                  = "${var.resource_prefix}-pdnsvnl-to-spoke"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = azurerm_private_dns_zone.this.resource_group_name
  virtual_network_id    = azurerm_virtual_network.this.id
  tags                  = var.tags

  lifecycle {
    ignore_changes = [
      tags["ASMS No"],
      tags["Business Criticality"],
      tags["Strictest Data Classification"],
      tags["Digital Asset Valuation"]
    ]
  }
}