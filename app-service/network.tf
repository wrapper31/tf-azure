resource "azurerm_private_endpoint" "this" {
  name                          = "${var.name_prefix}-pe-app-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.inbound_subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-app-${var.descriptor}"

  private_service_connection {
    name                           = "${var.name_prefix}-pl-app-${var.descriptor}"
    private_connection_resource_id = azurerm_linux_web_app.this.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
