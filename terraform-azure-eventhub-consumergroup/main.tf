resource "azurerm_eventhub_consumer_group" "this" {
  for_each = var.consumer_groups

  name                = each.value
  resource_group_name = var.resource_group_name
  namespace_name      = var.event_hub_namespace
  eventhub_name       = var.event_hub_name
  user_metadata       = "terraform"
}
