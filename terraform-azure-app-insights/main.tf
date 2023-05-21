resource "azurerm_application_insights" "this" {
  name                          = "${var.name_prefix}-appi-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  workspace_id                  = var.log_analytics_resource_id
  application_type              = var.application_type
  local_authentication_disabled = !var.enable_local_authentication

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
