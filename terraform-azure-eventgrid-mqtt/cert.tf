locals {
  mqttbroker_ca_certificates_type = "Microsoft.EventGrid/namespaces/caCertificates"
  # format cert strings in the format that EG mqtt - remove all new lines not in a header / footer line
  client_certs = { for index, value in var.client_certs :
    index => replace(value, "/([^-])\n([^-])|\n$/", "$1$2")
  }
}

resource "null_resource" "mqttbroker_root_cacertificates" {
  for_each = local.client_certs
  triggers = {
    body = jsonencode({
      location = var.location
      properties = {
        encodedCertificate = each.value
      }
    })
  }
}

resource "azapi_resource" "mqttbroker_root_cacertificates" {
  for_each                  = null_resource.mqttbroker_root_cacertificates
  schema_validation_enabled = false
  type                      = "${local.mqttbroker_ca_certificates_type}@${local.mqttbroker_api_version}"
  name                      = "${var.name_prefix}-cac-root-${each.key}"
  parent_id                 = azapi_resource.mqttbroker_namespace.id

  body = each.value.triggers.body

  lifecycle {
    # Force replace instead of update on changes since update is currently not supported.
    replace_triggered_by = [null_resource.mqttbroker_root_cacertificates]
  }
}
