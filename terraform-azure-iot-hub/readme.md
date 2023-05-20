<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.21.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | >=0.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.21.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.iothub_nw_rule_sets](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_eventgrid_system_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |
| [azurerm_iothub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |
| [azurerm_monitor_diagnostic_setting.eventgrid-diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.iot-diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | Resource name descriptor | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | category of logs to be collected see https://learn.microsoft.com/en-us/azure/iot-hub/monitor-iot-hub | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "Connections",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "DeviceTelemetry",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "C2DCommands",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "DeviceIdentityOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "FileUploadOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "Routes",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "D2CTwinOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "C2DTwinOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "TwinQueries",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "JobsOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "DirectMethods",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "DistributedTracing",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "Configurations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "DeviceStreams",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_diagnostic_metrics"></a> [diagnostic\_metrics](#input\_diagnostic\_metrics) | category of metrics to be collected see https://learn.microsoft.com/en-us/azure/iot-hub/tutorial-use-metrics-and-diags | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_dps_name"></a> [dps\_name](#input\_dps\_name) | DPS-name input from DPS module subsystem | `string` | n/a | yes |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | Whether or not to send logs and metrics to a Log Analytics Workspace | `bool` | n/a | yes |
| <a name="input_event_grid_subscriptions"></a> [event\_grid\_subscriptions](#input\_event\_grid\_subscriptions) | Map of tuples of event types to subscribe to, and the event hub ids to notify | <pre>map(object({<br>    event_types  = list(string)<br>    event_hub_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_event_hub_routes"></a> [event\_hub\_routes](#input\_event\_hub\_routes) | Eventhub route list | <pre>list(object({<br>    condition = string<br>    endpoint = object({<br>      eventhub_name             = string<br>      primary_connection_string = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_eventgrid_diagnostic_logs"></a> [eventgrid\_diagnostic\_logs](#input\_eventgrid\_diagnostic\_logs) | category of logs to be collected | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "DeliveryFailures",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_eventgrid_diagnostic_metrics"></a> [eventgrid\_diagnostic\_metrics](#input\_eventgrid\_diagnostic\_metrics) | category of metrics to be collected | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_iprule_action"></a> [iprule\_action](#input\_iprule\_action) | The desired action for ip filter rule- Accept/Reject | `string` | `"Accept"` | no |
| <a name="input_iprule_ipmask"></a> [iprule\_ipmask](#input\_iprule\_ipmask) | The IP address range in CIDR notation for ip filter rule | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource location | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled\_diagnostics is true | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Resource name prefix | `string` | n/a | yes |
| <a name="input_netrule_default_action"></a> [netrule\_default\_action](#input\_netrule\_default\_action) | Default Action for Network Rule Set- Deny/Allow | `string` | `"Allow"` | no |
| <a name="input_netrule_to_builtin_evnthub_endpt"></a> [netrule\_to\_builtin\_evnthub\_endpt](#input\_netrule\_to\_builtin\_evnthub\_endpt) | Determines if Network Rule Set is also applied to the BuiltIn EventHub EndPoint of the IotHub | `bool` | `false` | no |
| <a name="input_pubnet_access_enabled"></a> [pubnet\_access\_enabled](#input\_pubnet\_access\_enabled) | Public Newtwork Access - true = allow / false = deny | `bool` | `false` | no |
| <a name="input_pvtnet_access_enabled"></a> [pvtnet\_access\_enabled](#input\_pvtnet\_access\_enabled) | Private Newtwork Access - true = allow / false = deny | `bool` | `true` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Parent resource group ID | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name that module is connected to | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Resource subnet | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iot_name"></a> [iot\_name](#output\_iot\_name) | IotHub Name- output to oher module subsystems |
| <a name="output_iothub_id"></a> [iothub\_id](#output\_iothub\_id) | IotHub ID- output to oher module subsystems |
| <a name="output_iothub_rg_name"></a> [iothub\_rg\_name](#output\_iothub\_rg\_name) | IotHub resource group name- output to oher module subsystems |
<!-- END_TF_DOCS -->
