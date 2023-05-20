<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_private_endpoint.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `location`| Azure location where resources should be deployed. | `string` | n/a | yes |
| `resource_prefix` | Prefix for the resource | `string` | n/a | yes |
| `descriptor` | Descriptor for the resource | `string` | n/a | yes |
| `resource_group_name` | Resource group | `string` | n/a | yes |
| `subnet_id` | Subnet id of the private endpoint tied to event hub | `string` | n/a | yes |
| `tags` | Tags for the resource | `map(any)` | n/a | yes |
| `sku` | Defines which tier to use. | `string` | n/a | yes |
| [event_hub](#event-hub-specification) | list(object) | `List of objects` | n/a | yes |
| `capacity`  | Specifies the Capacity / Throughput Units for a SKU namespace | `number` | 1 | no |
| [Auto inflate specification](#auto-inflate-specification) | Is Auto Inflate enabled for the EventHub Namespace, and what is maximum throughput? | `number` | null | no |

### Event hub specification

| Field Name | Type     | Description           | Default | Required |
|------------|----------|---------------------  |---------|----------|
| `name`     | string   | Name of the event hub | n/a     | yes      |
| `partitions` | number   | Number of partitions | 4   | yes      |
| `message retention` | number   | Number of days to retain messages | 1   | yes      |
| [authorization](#authorization-specification) | object   | Authorization for event hub | n/a    | yes      |


### Authorization specification
| Field Name | Type   | Description           | Default | Required |
|------------|--------|---------------------  |---------|----------|
| `name`     | string | Name of authorization rule      | n/a     | yes      |
| `listen`   | bool   | Listen permission     | n/a     | yes      |
| `send`     | bool   | Send permission       | n/a     | yes      |
| `manage`   | bool   | Manage permission     | n/a     | yes      |

### Auto inflate specification
| Field Name | Type   | Description           | Default | Required |
|------------|--------|---------------------  |---------|----------|
| `enabled`   | bool   | Boolean value to enable the autoinflate     | n/a     | yes      |
| `maximum_throughput_units`     | number   | maximum number of throughput units when Auto Inflate is Enabled.Valid values range from 1 - 20.       | n/a     | yes      |

## Example

The below is a sample for this module creation.

```yaml
module "eventhub" {
  source = "../terraform-azure-event-hub"
  resource_group_name = local.resource_group_name
  location = local.location
  sku = "Standard"
  tags = local.tags
  subnet_id = "/subscriptions/test/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet"
  resource_prefix = "${local.resource_prefix}"
  descriptor = "${local.descriptor}"
  event_hub = [{
    name = "test1"
    partitions = 2
    message_retention = 1
    authorization =  {
      name = "test1-rule"
      listen = true
      send = true
      manage = false
    }
  },
  {
    name = "test2"
    partitions = 2
    message_retention = 1
    authorization =  {
      name = "test2-rule"
      listen = true
      send = true
      manage = false
    }
  }]
}
```

## Outputs

| Name | Description |
|------|-------------|
|`authorization_rules` | Authorization rules for eventhub |
| `eventhub_namespace` | Name of Event Hub Namespace |
| `eventhub_names` | List of event hub names under namespace | 
<!-- END_TF_DOCS -->
