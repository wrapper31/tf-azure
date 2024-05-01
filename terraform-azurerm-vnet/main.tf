resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name == null ? "${var.resource_prefix}-rg-net" : var.resource_group_name
  location = var.location
  tags     = var.tags

  lifecycle {
    ignore_changes = [
      tags["ASMS Status"],
      tags["Alternate Innovation Owner Email"],
      tags["Alternate Operations Owner Email"],
      tags["Application Acronym"],
      tags["Business Function"],
      tags["Business Sub Function"],
      tags["Innovation Owner Email"],
      tags["Operations Owner Email"],
      tags["Owning Organization"],
      tags["ASMS No"],
      tags["Business Criticality"],
      tags["Strictest Data Classification"],
      tags["Digital Asset Valuation"]
    ]
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.resource_prefix}-vnet-main"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_cidr_ranges
  dns_servers         = [local.firewall_ip]

  ddos_protection_plan {
    enable = true
    id     = var.ddos_protection_plan_id
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["ASMS No"],
      tags["Business Criticality"],
      tags["Strictest Data Classification"],
      tags["Digital Asset Valuation"],
    ]
  }
}