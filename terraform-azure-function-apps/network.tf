# resource "azurerm_app_service_virtual_network_swift_connection" "example" {
#   app_service_id = azurerm_linux_function_app.this.id
#   subnet_id      = var.subnet_id
# }

resource "azurerm_private_endpoint" "this" {
  name                          = "${var.name_prefix}-pe-func-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-func-${var.descriptor}"
  private_service_connection {
    name                           = "${var.name_prefix}-pl-func-${var.descriptor}"
    private_connection_resource_id = azurerm_linux_function_app.this.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
