
#############################
# Azure Managed Grafana Workspace
#############################

resource "azurerm_dashboard_grafana" "this" {
  name                              = "${var.name_prefix_no_dash}amg${var.descriptor}"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = var.public_network_access_enabled
  zone_redundancy_enabled           = false
  identity {
    type = "SystemAssigned"
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_private_endpoint" "this" {
  count = var.pvtnet_access_enabled ? 1 : 0

  name                          = "${var.name_prefix}-pe-amg-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-amg-${var.descriptor}"

  private_service_connection {
    name                           = "${var.name_prefix}-pl-amg-${var.descriptor}"
    private_connection_resource_id = azurerm_dashboard_grafana.this.id
    is_manual_connection           = false
    subresource_names              = ["grafana"]
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

// To PROVIDE ACCESS TO USER TO CREATE & MANAGE GRAFANA DASHBOARDS AND DATASOURCES
module "grafana_role_assignment" {
  for_each              = var.grafana_role_assignment
  source                = "../terraform-azurerm-role-assignment"
  principal_id          = each.key
  scope_id              = azurerm_dashboard_grafana.this.id
  role_definition_names = each.value
  tags                  = local.tags
}

// PROVIDE ACCESS TO GRAFANA TO QUERY AZURE RESOURCES MONITORING DATA
module "grafana_dashboard_monitoring_reader" {
  count                 = length(var.monitoring_reader_scope)
  source                = "../terraform-azurerm-role-assignment"
  principal_id          = azurerm_dashboard_grafana.this.identity[0].principal_id
  scope_id              = element(var.monitoring_reader_scope, count.index)
  role_definition_names = ["Monitoring Reader"]
  tags                  = local.tags
}
