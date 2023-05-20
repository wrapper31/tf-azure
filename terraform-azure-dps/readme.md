<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.21.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.21.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_iothub_dps.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps) | resource |
| [azurerm_iothub_dps_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps_certificate) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static) | `string` | `"GeoLatency"` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | Resource name descriptor | `string` | n/a | yes |
| <a name="input_device_root_cert"></a> [device\_root\_cert](#input\_device\_root\_cert) | The Base-64 representation of the X509 leaf certificate .cer file or just a .pem file content | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | categories of logs to be enabled | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "DeviceOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "ServiceOperations",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_diagnostic_metrics"></a> [diagnostic\_metrics](#input\_diagnostic\_metrics) | values of metrics to be enabled | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_ip_filter_rule_action"></a> [ip\_filter\_rule\_action](#input\_ip\_filter\_rule\_action) | The desired action for ip filter rule- Accept/Reject | `string` | `"Accept"` | no |
| <a name="input_ip_filter_rule_ip_mask"></a> [ip\_filter\_rule\_ip\_mask](#input\_ip\_filter\_rule\_ip\_mask) | The IP address range in CIDR notation for ip filter rule | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource location | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | value of the log analytics workspace id | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Resource name prefix | `string` | n/a | yes |
| <a name="input_pubnet_access_enabled"></a> [pubnet\_access\_enabled](#input\_pubnet\_access\_enabled) | Public Newtwork Access - true = allow / false = deny | `bool` | `false` | no |
| <a name="input_pvtnet_access_enabled"></a> [pvtnet\_access\_enabled](#input\_pvtnet\_access\_enabled) | Private Newtwork Access - true = allow / false = deny | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name that module is connected to | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Resource subnet | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dps_name"></a> [dps\_name](#output\_dps\_name) | DPS-name output to oher module subsystems |
<!-- END_TF_DOCS -->
