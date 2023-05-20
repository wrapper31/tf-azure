## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Name of existing app insights instance to write traces to | `string` | n/a | yes |
| <a name="input_app_insights_resource_group_name"></a> [app\_insights\_resource\_group\_name](#input\_app\_insights\_resource\_group\_name) | Name of resource group containing existing app insights instance | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | n/a | `map(any)` | `{}` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | n/a | `string` | n/a | yes |
| <a name="input_java_version"></a> [java\_version](#input\_java\_version) | Java Version | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_name_prefix_no_dash"></a> [name\_prefix\_no\_dash](#input\_name\_prefix\_no\_dash) | n/a | `string` | n/a | yes |
| <a name="input_outbound_subnet_id"></a> [outbound\_subnet\_id](#input\_outbound\_subnet\_id) | The ID of the outbound subnet for the Vnet Integration | `string` | n/a | yes |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | Paython Version | `string` | `null` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | n/a | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_function_app_id"></a> [linux\_function\_app\_id](#output\_linux\_function\_app\_id) | linux\_function\_app ID- output to oher module subsystems |
| <a name="output_linux_function_app_name"></a> [linux\_function\_app\_name](#output\_linux\_function\_app\_name) | linux\_function\_app Name-output to oher module subsystems |
| <a name="output_linux_function_app_rg_name"></a> [linux\_function\_app\_rg\_name](#output\_linux\_function\_app\_rg\_name) | linux\_function\_app resource group name- output to oher module subsystems |
