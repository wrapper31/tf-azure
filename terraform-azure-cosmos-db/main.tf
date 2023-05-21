data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

#  azure cosmos defender update as https://learn.microsoft.com/en-us/azure/templates/microsoft.security/2018-06-01/pricings?pivots=deployment-language-terraform#terraform-azapi-provider-resource-definition
resource "azapi_update_resource" "this" {
  type      = "Microsoft.Security/pricings@2022-03-01"
  name      = "CosmosDbs"
  parent_id = data.azurerm_subscription.current.id
  body = jsonencode({
    properties = {
      pricingTier = "Standard"
    }
  })
}

locals {
  # IP range given by GMIT representing public addresses of all machines on the GM network
  gm_network_range = "198.208.0.0/16"
  sql_db           = { for db in var.databases : db.name => db }
  all_containers = flatten([
    for database_key, database_value in var.databases : [
      for container_key, container_value in database_value.containers : {
        db_name            = database_value.name
        container_key      = container_key
        partition_key_path = container_value["partition_key_path"]
        unique_keys        = container_value["unique_keys"]
        indexing_mode      = container_value["indexing_mode"]
        included_paths     = container_value["included_paths"]
        excluded_paths     = container_value["excluded_paths"]
        default_timetolive = container_value["default_timetolive"]
      }
    ]
  ])
}

resource "azurerm_cosmosdb_account" "this" {
  name                               = "${var.name_prefix}-cosmos-${var.descriptor}"
  location                           = var.location
  resource_group_name                = var.resource_group_name
  offer_type                         = "Standard"
  kind                               = "GlobalDocumentDB"
  public_network_access_enabled      = var.public_network_access_enabled
  ip_range_filter                    = var.public_network_access_enabled ? local.gm_network_range : null
  enable_automatic_failover          = true
  local_authentication_disabled      = !var.local_authentication_enabled
  access_key_metadata_writes_enabled = var.access_key_metadata_writes_enabled

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.location
    failover_priority = 0
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

resource "azurerm_management_lock" "prevent_destroy" {
  count = var.prevent_destroy ? 1 : 0

  name       = "PreventDestroy"
  scope      = azurerm_cosmosdb_account.this.id
  lock_level = "CanNotDelete"
  notes      = "Care should be taken when deleting resources with data."

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_database" "this" {
  for_each = local.sql_db

  name                = each.key
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = 1000
}

resource "azurerm_cosmosdb_sql_container" "this" {
  for_each = {
    for container in local.all_containers : container.container_key => container
  }

  name                  = each.key
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this[each.value.db_name].name
  partition_key_path    = each.value.partition_key_path
  partition_key_version = 1
  throughput            = 400
  default_ttl           = each.value.default_timetolive

  indexing_policy {
    indexing_mode = each.value.indexing_mode

    dynamic "included_path" {
      for_each = each.value.included_paths
      content {
        path = included_path.value
      }
    }

    dynamic "excluded_path" {
      for_each = each.value.excluded_paths
      content {
        path = excluded_path.value
      }
    }
  }

  dynamic "unique_key" {
    for_each = length(each.value.unique_keys) != 0 ? [1] : []

    content {
      paths = each.value.unique_keys
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  name                          = "${var.name_prefix}-pe-cosmos-${var.descriptor}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.name_prefix}-nic-cosmos-${var.descriptor}"

  private_service_connection {
    name                           = "${var.name_prefix}-pl-cosmos-${var.descriptor}"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
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

## diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_cosmosdb_account.this.name, "diag"))
  target_resource_id         = azurerm_cosmosdb_account.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_logs

    content {
      category = enabled_log.value.category

      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
