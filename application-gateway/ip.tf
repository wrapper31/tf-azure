resource "azurerm_public_ip_prefix" "this" {
  name                = "${var.name_prefix}-ippre-agw-${var.descriptor}"
  location            = var.location
  resource_group_name = var.resource_group_name
  zones               = ["1", "2", "3"]
  prefix_length       = 31
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }

}

resource "azurerm_public_ip" "this" {
  name                = "${var.name_prefix}-pip-agw-${var.descriptor}"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_ip_prefix_id = azurerm_public_ip_prefix.this.id
  allocation_method   = "Static"
  sku                 = var.sku_public_ip
  sku_tier            = var.sku_public_ip_tier
  domain_name_label   = "${var.name_prefix}-pip-agw-${var.descriptor}"
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      zones,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
