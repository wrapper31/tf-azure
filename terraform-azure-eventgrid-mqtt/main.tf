locals {
  mqttbroker_api_version = var.api_version != "" ? var.api_version : "2022-10-15-preview"
  mqttbroker_base_type   = "Microsoft.EventGrid/namespaces"
}

###
# Event Grid Topic
###

resource "azurerm_eventgrid_topic" "mqttbroker" {
  name = "${var.name_prefix}-evgt-${var.descriptor}"
  # Must be created in the private preview location
  location            = var.location
  resource_group_name = var.resource_group_name

  # Only supports V1 CloudEventSchema, currently.
  input_schema                  = "CloudEventSchemaV1_0"
  public_network_access_enabled = true
  # look into security hardening
  local_auth_enabled = true

  identity {
    type = "SystemAssigned"
  }
}


## base namespace..
resource "null_resource" "mqttbroker_namespace" {
  triggers = {
    body = jsonencode({
      location = var.location
      properties = {
        topicsConfiguration = {
          inputSchema = "CloudEventSchemaV1_0"
        }

        topicSpacesConfiguration = {
          state                = "Enabled"
          routeTopicResourceId = azurerm_eventgrid_topic.mqttbroker.id
        }
        tags = var.tags
      }
    })
  }
}

resource "azapi_resource" "mqttbroker_namespace" {
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_base_type}@${local.mqttbroker_api_version}"
  name                      = "${var.name_prefix}-evgns-${var.descriptor}"
  parent_id                 = var.resource_group_id

  body = null_resource.mqttbroker_namespace.triggers.body

  lifecycle {
    # Force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [null_resource.mqttbroker_namespace]
  }

  depends_on = [
    azurerm_role_assignment.eventgrid_topic_self
  ]
}
