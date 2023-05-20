output "mqtt_gateway_hostname" {
  value = "${azapi_resource.mqttbroker_namespace.name}.${var.location}-1.ts.eventgrid.azure.net"
}

output "namespace_name" {
  value = azapi_resource.mqttbroker_namespace.name
}

output "mqtt_topic_name" {
  value = azurerm_eventgrid_topic.mqttbroker.name
}

output "namespace_id" {
  value = azapi_resource.mqttbroker_namespace.id
}

output "mqtt_topic_id" {
  value = azurerm_eventgrid_topic.mqttbroker.id
}

output "identity" {
  value = azurerm_eventgrid_topic.mqttbroker.identity
}
