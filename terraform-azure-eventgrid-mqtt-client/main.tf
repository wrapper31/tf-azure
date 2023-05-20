locals {
  mqttbroker_api_version  = var.api_version != "" ? var.api_version : "2022-10-15-preview"
  mqttbroker_clients_type = "Microsoft.EventGrid/namespaces/clients"
}


resource "null_resource" "broker_client" {
  triggers = {
    body = jsonencode({
      properties = {
        state = "Enabled"
        # currently only a subset of subject fields are used for client certificate validation.
        clientCertificateAuthentication = {
          validationScheme = "SubjectMatchesAuthenticationName"
        }
        attributes  = var.attributes
        description = var.description
      }
    })
  }
}

resource "azapi_resource" "mqttbroker_client" {
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_clients_type}@${local.mqttbroker_api_version}"
  # name must match the client id used when initiating a connection to the mqtt broker.
  name      = var.name
  parent_id = var.mqtt_broker_namespace_id

  body = null_resource.broker_client.triggers.body

  lifecycle {
    # force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [
      null_resource.broker_client
    ]
  }
}
