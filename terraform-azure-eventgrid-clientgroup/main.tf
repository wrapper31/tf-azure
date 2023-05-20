locals {
  mqttbroker_api_version        = var.api_version != "" ? var.api_version : "2022-10-15-preview"
  mqttbroker_client_groups_type = "Microsoft.EventGrid/namespaces/clientGroups"
}

resource "null_resource" "client_group" {
  triggers = {
    body = jsonencode({
      location = var.location
      properties = {
        # Query that will combine all similar clients into a group then used for granting permissions.
        query       = var.query
        description = var.description
      }
    })
  }
}

resource "azapi_resource" "client_group" {
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_client_groups_type}@${local.mqttbroker_api_version}"
  name                      = "${var.name_prefix}-egcg-${var.descriptor}"
  parent_id                 = var.mqtt_broker_id

  body                    = null_resource.client_group.triggers.body
  tags                    = var.tags
  ignore_missing_property = true
  ignore_casing           = true
  lifecycle {
    # Force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [null_resource.client_group]
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
