resource "azurerm_network_interface" "this" {
  name                = "${var.name_prefix}-nic-vm-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "Configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      
    ]
  }
}
