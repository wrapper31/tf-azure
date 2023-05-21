resource "azurerm_container_registry" "this" {
  name                          = "${var.name_prefix_no_dash}cr${var.descriptor}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = false
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  // this is required for Azure ML workspace, compute clusters and instance subnets to have access to ACR
  dynamic "network_rule_set" {
    for_each = (length(var.allowed_ips) != 0 || length(var.allowed_subnet_ids) != 0) ? [1] : []
    content {
      default_action = "Deny"
      dynamic "virtual_network" {
        for_each = var.allowed_subnet_ids
        content {
          action    = "Allow"
          subnet_id = virtual_network.value
        }
      }
      dynamic "ip_rule" {
        for_each = var.allowed_ips
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_management_lock" "prevent_destroy" {
  count = var.prevent_destroy ? 1 : 0

  name       = "PreventDestroy"
  scope      = azurerm_container_registry.this.id
  lock_level = "CanNotDelete"
  notes      = "Care should be taken when deleting resources with data."

  lifecycle {
    prevent_destroy = true
  }
}
