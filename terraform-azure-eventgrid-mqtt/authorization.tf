###
# Roles
###

data "azurerm_role_definition" "eventgrid_data_sender" {
  name  = "EventGrid Data Sender"
  scope = azurerm_eventgrid_topic.mqttbroker.id
}

# Get principal for current client that is executing the Terraform.
data "azurerm_client_config" "self" {
}

resource "azurerm_role_assignment" "eventgrid_topic_self" {
  scope              = azurerm_eventgrid_topic.mqttbroker.id
  role_definition_id = data.azurerm_role_definition.eventgrid_data_sender.role_definition_id
  principal_id       = data.azurerm_client_config.self.object_id
}
