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
| [azurerm_eventhub_consumer_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consumer_groups"></a> [consumer\_groups](#input\_consumer\_groups) | A list of consumer groups | `set(string)` | n/a | yes |
| <a name="input_event_hub_name"></a> [event\_hub\_name](#input\_event\_hub\_name) | Name of the event hub to add consumer groups | `string` | n/a | yes |
| <a name="input_event_hub_namespace"></a> [event\_hub\_namespace](#input\_event\_hub\_namespace) | Namespace of the event hub | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name where resource should be deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created | `map(string)` | n/a | yes |

## Outputs

No outputs.

## Example

The below is a sample for this module creation.

```yaml
module "eventhub_consumer_group" {
  source = "../terraform-azure-eventhub-consumergroup"
  resource_group_name = local.resource_group_name
  event_hub_namespace = module.eventhub.eventhub_namespace
  event_hub_name = module.eventhub.eventhub_names[0]
  consumer_groups = ["test1", "test2", "test3"]
  tags = local.tags
}
```
<!-- END_TF_DOCS -->
