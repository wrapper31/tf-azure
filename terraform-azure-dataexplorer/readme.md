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
| [azurerm_kusto_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.dataexplorer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_user_assigned_identity.cluster_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_all_public_networks"></a> [allow\_all\_public\_networks](#input\_allow\_all\_public\_networks) | n/a | `bool` | `false` | no |
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | List of public IP or IP ranges in CIDR Format | `list(string)` | <pre>[<br>  "198.208.0.0/16"<br>]</pre> | no |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_auto_stop_enabled"></a> [auto\_stop\_enabled](#input\_auto\_stop\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_cluster_capacity"></a> [cluster\_capacity](#input\_cluster\_capacity) | Node count of the Kusto cluster | `number` | n/a | yes |
| <a name="input_cluster_sku"></a> [cluster\_sku](#input\_cluster\_sku) | sku of the data explorer | `string` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | n/a | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | category of logs to be collected | <pre>set(object({<br>    category          = string<br>    category_group    = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": null,<br>    "category_group": "allLogs",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": null,<br>    "category_group": "audit",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_diagnostic_metrics"></a> [diagnostic\_metrics](#input\_diagnostic\_metrics) | value is a list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/data-factory/monitor-metrics-alerts | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group where the ADX Cluster will be created | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Location prefix of the azure resource group | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | workspace id for log analytics | `string` | n/a | yes |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | n/a | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the ADX Cluster will be created | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for all resource names | `string` | n/a | yes |
| <a name="input_streaming_ingestion_enabled"></a> [streaming\_ingestion\_enabled](#input\_streaming\_ingestion\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | subnet id where the private endpoint will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_identity_name"></a> [cluster\_identity\_name](#output\_cluster\_identity\_name) | Kusto cluster user assigned identity |
| <a name="output_id"></a> [id](#output\_id) | Dataexplorer ID |
| <a name="output_name"></a> [name](#output\_name) | Dataexplorer Name |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Dataexplorer resource\_group\_name |
<!-- END_TF_DOCS -->
