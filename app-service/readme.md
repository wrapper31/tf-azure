## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.15.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate) | resource |
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.appservice_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azuread_service_principal.microsoft_web_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Map of app settings to be passed to the Application Service | `map(string)` | `{}` | no |
| <a name="input_app_svc_plan_os_type"></a> [app\_svc\_plan\_os\_type](#input\_app\_svc\_plan\_os\_type) | App Service Plan OS Type | `string` | `"Linux"` | no |
| <a name="input_app_svc_plan_sku_name"></a> [app\_svc\_plan\_sku\_name](#input\_app\_svc\_plan\_sku\_name) | App Service Plan SKU Name | `string` | `"P1v3"` | no |
| <a name="input_application_stack"></a> [application\_stack](#input\_application\_stack) | application stack for app service | `map(string)` | <pre>{<br>  "node_version": "16-lts"<br>}</pre> | no |
| <a name="input_auth_settings"></a> [auth\_settings](#input\_auth\_settings) | Authentication settings. Issuer URL is generated thanks to the tenant ID. For active\_directory block, the allowed\_audiences list is filled with a value generated with the name of the App Service. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#auth_settings | `any` | `{}` | no |
| <a name="input_azure_app_service_principal_id"></a> [azure\_app\_service\_principal\_id](#input\_azure\_app\_service\_principal\_id) | The ID of the Microsoft Azure App Service SP in the tenant in case it is not read dynamically, the default is for the GM tenant | `string` | `"cb630454-7874-43b8-bf32-65bd6d222095"` | no |
| <a name="input_certificate_name"></a> [certificate\_name](#input\_certificate\_name) | The name of the certificate for the custom hostname | `string` | `null` | no |
| <a name="input_certificate_secret_id"></a> [certificate\_secret\_id](#input\_certificate\_secret\_id) | The secret ID of the certificate for the custom hostname | `string` | `null` | no |
| <a name="input_custom_domain_hostname"></a> [custom\_domain\_hostname](#input\_custom\_domain\_hostname) | Custom hostname for the Application Service | `string` | `null` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | The descriptor which will added at the end of the resource name | `string` | n/a | yes |
| <a name="input_inbound_subnet_id"></a> [inbound\_subnet\_id](#input\_inbound\_subnet\_id) | The ID of the subnet for the private endpoint to be placed in | `string` | n/a | yes |
| <a name="input_ip_restriction"></a> [ip\_restriction](#input\_ip\_restriction) | GM IP range restriction | <pre>set(object({<br>    name                      = string<br>    priority                  = number<br>    ip_address                = string<br>    virtual_network_subnet_id = string<br>    service_tag               = string<br><br>  }))</pre> | <pre>[<br>  {<br>    "action": "Allow",<br>    "ip_address": "198.208.0.0/16",<br>    "name": "GM_Network_Access",<br>    "priority": 600,<br>    "service_tag": null,<br>    "virtual_network_subnet_id": null<br>  }<br>]</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the key vault containing the certificate for the custom hostname | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource location | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name.i.e. a210298-s1-musea2 | `string` | n/a | yes |
| <a name="input_node_version"></a> [node\_version](#input\_node\_version) | Node Version | `string` | `null` | no |
| <a name="input_outbound_subnet_id"></a> [outbound\_subnet\_id](#input\_outbound\_subnet\_id) | The ID of the outbound subnet for the Vnet Integration | `string` | n/a | yes |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | Paython Version | `string` | `null` | no |
| <a name="input_read_azure_app_service_principal_id"></a> [read\_azure\_app\_service\_principal\_id](#input\_read\_azure\_app\_service\_principal\_id) | Whether to read the ID of the Microsoft Azure App Service SP from AD dynamically | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resouce group name to provision resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tag name (key=value) | `map(any)` | n/a | yes |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of Workers for this Linux App Service | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_Service_cert_id"></a> [app\_Service\_cert\_id](#output\_app\_Service\_cert\_id) | app\_Service\_cert ID- output to other module subsystems |
| <a name="output_app_Service_cert_name"></a> [app\_Service\_cert\_name](#output\_app\_Service\_cert\_name) | app\_Service\_cert Name-output to other module subsystems |
| <a name="output_app_Service_cert_rg_name"></a> [app\_Service\_cert\_rg\_name](#output\_app\_Service\_cert\_rg\_name) | app\_Service\_cert resource group name- output to other module subsystems |
| <a name="output_app_service"></a> [app\_service](#output\_app\_service) | azurerm\_linux\_web\_app resource |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | linux\_web\_app default hostname- output to other module subsystems |
| <a name="output_linux_web_app_id"></a> [linux\_web\_app\_id](#output\_linux\_web\_app\_id) | linux\_web\_app ID- output to other module subsystems |
| <a name="output_linux_web_app_name"></a> [linux\_web\_app\_name](#output\_linux\_web\_app\_name) | linux\_web\_app Name-output to other module subsystems |
| <a name="output_linux_web_app_rg_name"></a> [linux\_web\_app\_rg\_name](#output\_linux\_web\_app\_rg\_name) | linux\_web\_app resource group name- output to other module subsystems |
