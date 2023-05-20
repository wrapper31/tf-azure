locals {
  mqttbroker_api_version       = var.api_version != "" ? var.api_version : "2022-10-15-preview"
  mqttbroker_topic_spaces_type = "Microsoft.EventGrid/namespaces/topicSpaces"
}

resource "null_resource" "topic_spaces" {
  triggers = {
    body = jsonencode({
      location = var.location
      properties = {
        topicTemplates      = var.templates
        subscriptionSupport = var.subscription_support
      }
    })
  }
}

resource "azapi_resource" "topic_spaces" {
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_topic_spaces_type}@${local.mqttbroker_api_version}"
  name                      = "${var.name_prefix}-egts-${var.descriptor}"
  parent_id                 = var.mqtt_broker_id

  body                    = null_resource.topic_spaces.triggers.body
  tags                    = var.tags
  ignore_missing_property = true
  ignore_casing           = true
  lifecycle {
    # Force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [null_resource.topic_spaces]
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
