## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | White list IP addresses - typically, GM VPN IP | `list(string)` | `[]` | no |
| <a name="input_allowed_subnet_ids"></a> [allowed\_subnet\_ids](#input\_allowed\_subnet\_ids) | List of subnet IDs to be allowed to access the ACR | `list(string)` | `[]` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | The descriptor which will added at the end of the resource name | `string` | n/a | yes |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Create a private endpoint for the container registry | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where resources need to be build | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | The resource ID of the Log Analytics Workspace to which logs and metrics will be sent | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name.i.e. a210298-s1-musea2 | `string` | n/a | yes |
| <a name="input_name_prefix_no_dash"></a> [name\_prefix\_no\_dash](#input\_name\_prefix\_no\_dash) | The prefix name wothout dashes.i.e. a210298s1musea2 | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resouce group name to provision resources | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU used for the creation of the container registry | `string` | `"Premium"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet id which you want to refere for your resource provisioning | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tag name (key=value) | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr"></a> [acr](#output\_acr) | azurerm\_container\_registry resource |
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the container registry |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | Specifies the login server of the container registry |
| <a name="output_login_server_url"></a> [login\_server\_url](#output\_login\_server\_url) | Specifies the login server url of the container registry |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the container registry |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Specifies the resource group name of the container registry |
