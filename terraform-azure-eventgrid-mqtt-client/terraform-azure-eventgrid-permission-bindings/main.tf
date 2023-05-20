locals {
  mqttbroker_api_version              = var.api_version != "" ? var.api_version : "2022-10-15-preview"
  mqttbroker_permission_bindings_type = "Microsoft.EventGrid/namespaces/permissionBindings"
}

resource "null_resource" "permission_bindings" {
  triggers = {
    body = jsonencode({
      location = var.location
      properties = {
        clientGroupName = var.client_group_name
        topicSpaceName  = var.topic_name
        permission      = var.permission_role
      }
    })
  }
}

resource "azapi_resource" "permission_bindings" {
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_permission_bindings_type}@${local.mqttbroker_api_version}"
  name                      = "${var.name_prefix}-egpb-${var.descriptor}"
  parent_id                 = var.mqtt_broker_id

  body                    = null_resource.permission_bindings.triggers.body
  tags                    = var.tags
  ignore_missing_property = true
  ignore_casing           = true

  lifecycle {
    # Force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [null_resource.permission_bindings]
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
