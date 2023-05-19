resource "azurerm_service_plan" "this" {
  name                = "${var.name_prefix}-asp-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.app_svc_plan_os_type
  sku_name            = var.app_svc_plan_sku_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
