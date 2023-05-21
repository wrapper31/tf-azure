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
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | Specifies the type of Application Insights to create | `string` | `"other"` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | The descriptor which will added at the end of the resource name | `string` | n/a | yes |
| <a name="input_enable_local_authentication"></a> [enable\_local\_authentication](#input\_enable\_local\_authentication) | Enabling local authentication, excludes AD based authentication | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where resources need to be build | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | The resource ID of the Log Analytics Workspace to which logs and metrics will be sent | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name.i.e. a210298-s1-musea2 | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resouce group name to provision resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tag name (key=value) | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | value of the app id |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | Connection string for the Application Insights instance |
| <a name="output_id"></a> [id](#output\_id) | ID of the application insights instance |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | Value of the instrumentation key |
| <a name="output_name"></a> [name](#output\_name) | Name of the application insights instance |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Resource group name of the application insights instance |
