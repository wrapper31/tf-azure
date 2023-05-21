resource "azurerm_user_assigned_identity" "cluster_identity" {
  name                = "${var.resource_prefix}-id-adx-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_kusto_cluster" "this" {
  name                = "${local.resource_prefix_no_dash}dec${var.descriptor}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = var.cluster_sku
    capacity = var.cluster_capacity
  }

  disk_encryption_enabled       = true
  allowed_ip_ranges             = var.allow_all_public_networks ? null : var.allowed_ip_ranges
  auto_stop_enabled             = var.auto_stop_enabled
  public_network_access_enabled = var.allow_all_public_networks || var.public_network_access
  streaming_ingestion_enabled   = var.streaming_ingestion_enabled
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.cluster_identity.id
    ]
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

resource "azurerm_private_endpoint" "dataexplorer" {
  name                          = "${local.name_prefix}-pe-${var.descriptor}-main"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${local.name_prefix}-nic-${var.descriptor}"
  private_service_connection {
    name                           = "${local.name_prefix}-pl-${var.descriptor}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_kusto_cluster.this.id
    subresource_names              = ["cluster"]
  }
  tags = local.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group,
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
