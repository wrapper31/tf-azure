resource "azurerm_portal_dashboard" "this" {
  name                = "${var.name_prefix}-dashboard-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  # For generating json representation of a dashboard, follow stps below, then add json file as template for each rg
  # https://learn.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards-create-programmatically#fetch-the-json-representation-of-the-dashboard
  # Apply templatefile function to a template to generate dashboard_porperties string.
  dashboard_properties = var.dashboard_properties
  tags                 = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
