resource "azurerm_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1 : 0

  name                          = "${var.name_prefix}-pe-cr-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-cr-${var.descriptor}"

  private_service_connection {
    name                           = "${var.name_prefix}-pl-cr-${var.descriptor}"
    private_connection_resource_id = azurerm_container_registry.this.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
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
