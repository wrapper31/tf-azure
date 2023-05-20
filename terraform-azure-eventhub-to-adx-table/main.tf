# Data connections for dependencies

## ADX references
data "azurerm_kusto_cluster" "adx_cluster" {
  name                = var.adx_cluster.name
  resource_group_name = var.adx_cluster.resource_group_name
}

data "azurerm_kusto_database" "adx_database" {
  name                = var.adx_database_name
  resource_group_name = var.adx_cluster.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.adx_cluster.name
}

data "azurerm_user_assigned_identity" "adx_identity" {
  name                = var.adx_cluster.identity_name
  resource_group_name = var.adx_cluster.resource_group_name
}

## Event Hub namespace
data "azurerm_eventhub_namespace" "source_ingest_eventhub_namespace" {
  name                = var.source_event_hub_namespace.name
  resource_group_name = var.source_event_hub_namespace.resource_group_name
}

locals {
  ingest_template_content = templatefile(
    "${path.module}/ingest_table.template.kql",
    {
      ingest_table_names : [for eh in var.source_event_hubs : "${var.descriptor}_${eh.event_hub_name}_${var.adx_target_table_name}"]
      maximum_batching_timespan : var.maximum_batching_timespan
    }
  )
  ingest_template_content_hash = md5(local.ingest_template_content)
}

# Create ADX components
resource "azurerm_kusto_script" "create-tables" {
  name                               = "${var.descriptor}_${var.source_event_hub_namespace.name}_${var.adx_target_table_name}"
  database_id                        = data.azurerm_kusto_database.adx_database.id
  script_content                     = local.ingest_template_content
  continue_on_errors_enabled         = true
  force_an_update_when_value_changed = local.ingest_template_content_hash
}

resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection" {
  for_each = {
    for index, eh in var.source_event_hubs :
    eh.event_hub_name => eh
  }

  name                = "${var.resource_prefix}-adxdc-${each.value.event_hub_name}-${var.descriptor}"
  resource_group_name = data.azurerm_kusto_cluster.adx_cluster.resource_group_name
  location            = data.azurerm_kusto_cluster.adx_cluster.location
  cluster_name        = data.azurerm_kusto_cluster.adx_cluster.name
  database_name       = var.adx_database_name

  eventhub_id       = each.value.event_hub_id
  consumer_group    = each.value.consumer_group_name
  identity_id       = data.azurerm_user_assigned_identity.adx_identity.id
  table_name        = "${var.descriptor}_${each.value.event_hub_name}_${var.adx_target_table_name}"
  mapping_rule_name = "${var.descriptor}_${each.value.event_hub_name}_${var.adx_target_table_name}_mapping"
  event_system_properties = [
    "x-opt-enqueued-time",
    "x-opt-sequence-number",
    "x-opt-offset",
    "x-opt-publisher",
    "x-opt-partition-key"
  ]

  data_format = "MULTIJSON"

  depends_on = [
    azurerm_kusto_script.create-tables
  ]
}

#Grant Event Hub Data Receiver role to source event hub
resource "azurerm_role_assignment" "cluster_eh_receiver" {
  for_each = {
    for index, eh in var.source_event_hubs :
    eh.event_hub_name => eh
  }

  principal_id         = data.azurerm_user_assigned_identity.adx_identity.principal_id
  scope                = each.value.event_hub_id
  role_definition_name = "Azure Event Hubs Data Receiver"
}

#Managed private endpoint for ingestion
resource "azurerm_kusto_cluster_managed_private_endpoint" "adx_eh_endpoint" {
  name                         = "${var.resource_prefix}-adxmpe-${var.source_event_hub_namespace.name}"
  resource_group_name          = data.azurerm_kusto_cluster.adx_cluster.resource_group_name
  cluster_name                 = data.azurerm_kusto_cluster.adx_cluster.name
  private_link_resource_id     = data.azurerm_eventhub_namespace.source_ingest_eventhub_namespace.id
  private_link_resource_region = data.azurerm_eventhub_namespace.source_ingest_eventhub_namespace.location
  group_id                     = "namespace"
  request_message              = "Please Approve"
}

resource "null_resource" "endpoint_approval" {
  depends_on = [azurerm_kusto_cluster_managed_private_endpoint.adx_eh_endpoint]
  provisioner "local-exec" {
    command = <<-EOT
      MPE_ID=$(az network private-endpoint-connection list --id ${data.azurerm_eventhub_namespace.source_ingest_eventhub_namespace.id} --query "[?contains(properties.privateEndpoint.id, '${azurerm_kusto_cluster_managed_private_endpoint.adx_eh_endpoint.name}')].id" -o tsv)
      MPE_STATUS=$(az network private-endpoint-connection list --id ${data.azurerm_eventhub_namespace.source_ingest_eventhub_namespace.id} --query "[?contains(properties.privateEndpoint.id, '${azurerm_kusto_cluster_managed_private_endpoint.adx_eh_endpoint.name}')].properties.privateLinkServiceConnectionState.status" -o tsv)
      if [ "$MPE_STATUS" = "Pending" ]; then
        az network private-endpoint-connection approve --id $MPE_ID --description "Approved in Terraform"
      fi
        EOT
  }
}
