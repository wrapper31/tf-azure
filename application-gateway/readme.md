Module for creating Azure Application Gateway with WAF and public IP.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.29.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip_prefix.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |
| [azurerm_role_assignment.key_vault_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_web_application_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscale_configuration"></a> [autoscale\_configuration](#input\_autoscale\_configuration) | Autoscale configuration | `map(string)` | `{}` | no |
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | List of objects that represent the configuration of each backend address pool | `list(map(string))` | n/a | yes |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | List of backend HTTP settings | `set(map(string))` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | The descriptor which will added at the end of the resource name | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | categories of logs to be enabled | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "ApplicationGatewayAccessLog",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "ApplicationGatewayPerformanceLog",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "ApplicationGatewayFirewallLog",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_diagnostic_metrics"></a> [diagnostic\_metrics](#input\_diagnostic\_metrics) | values of metrics to be enabled | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | Whether or not to send logs and metrics to a Log Analytics Workspace | `bool` | n/a | yes |
| <a name="input_frontend_port"></a> [frontend\_port](#input\_frontend\_port) | List of objects that represent the configuration of each port | `list(map(string))` | n/a | yes |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | List of objects that represent the configuration of each http listener | `list(map(string))` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | A key vault id for configuration of the application gateway to read secret | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the Application Gateway is created | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled\_diagnostics is true | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name.i.e. a210298-s1-musea2 | `string` | n/a | yes |
| <a name="input_probes"></a> [probes](#input\_probes) | List of objects that represent the configuration of each probe | `list(map(string))` | `[]` | no |
| <a name="input_request_routing_rules"></a> [request\_routing\_rules](#input\_request\_routing\_rules) | List of objects that represent the configuration of each backend request routing rule | `list(map(string))` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Application Gateway | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | A mapping with the sku configuration of the application gateway | `map(string)` | n/a | yes |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | List of objects that represent the configuration of each ssl certificate | <pre>map(object({<br>    name      = string<br>    secret_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID of the App gateway | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appgw_id"></a> [appgw\_id](#output\_appgw\_id) | app gateway ID- output to oher module subsystems |
| <a name="output_appgw_name"></a> [appgw\_name](#output\_appgw\_name) | app gateway Name-output to oher module subsystems |
| <a name="output_appgw_rg_name"></a> [appgw\_rg\_name](#output\_appgw\_rg\_name) | app gateway resource group name- output to oher module subsystems |
| <a name="output_application_gateway"></a> [application\_gateway](#output\_application\_gateway) | azurerm\_application\_gateway resource |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the public IP address associated with the Application Gateway |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | azurerm\_public\_ip resource |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | ip Address for Application gateway public IP |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | public\_ip ID- output to oher module subsystems |
| <a name="output_public_ip_name"></a> [public\_ip\_name](#output\_public\_ip\_name) | public\_ip Name-output to oher module subsystems |
| <a name="output_public_ip_prefix"></a> [public\_ip\_prefix](#output\_public\_ip\_prefix) | azurerm\_public\_ip\_prefix resource |
| <a name="output_public_ip_prefix_id"></a> [public\_ip\_prefix\_id](#output\_public\_ip\_prefix\_id) | public\_ip\_prefix ID- output to oher module subsystems |
| <a name="output_public_ip_prefix_name"></a> [public\_ip\_prefix\_name](#output\_public\_ip\_prefix\_name) | public\_ip\_prefix Name-output to oher module subsystems |
| <a name="output_public_ip_prefix_rg_name"></a> [public\_ip\_prefix\_rg\_name](#output\_public\_ip\_prefix\_rg\_name) | public\_ip\_prefix resource group name- output to oher module subsystems |
| <a name="output_public_ip_rg_name"></a> [public\_ip\_rg\_name](#output\_public\_ip\_rg\_name) | public\_ip resource group name- output to oher module subsystems |
| <a name="output_waf_policy_id"></a> [waf\_policy\_id](#output\_waf\_policy\_id) | web\_application\_firewall\_policy ID- output to oher module subsystems |
| <a name="output_waf_policy_name"></a> [waf\_policy\_name](#output\_waf\_policy\_name) | web\_application\_firewall\_policy Name-output to oher module subsystems |
| <a name="output_waf_policy_rg_name"></a> [waf\_policy\_rg\_name](#output\_waf\_policy\_rg\_name) | web\_application\_firewall\_policy resource group name- output to oher module subsystems |
| <a name="output_web_application_firewall_policy"></a> [web\_application\_firewall\_policy](#output\_web\_application\_firewall\_policy) | azurerm\_web\_application\_firewall\_policy resource |
<!-- END_TF_DOCS -->
