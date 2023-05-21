## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.39.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_access_connector.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_databricks_workspace_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace_customer_managed_key) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.kvsu](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.sbdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [databricks_group.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_user.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/user) | resource |
| [databricks_workspace_conf.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/workspace_conf) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/databricks_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ip_rules"></a> [allow\_ip\_rules](#input\_allow\_ip\_rules) | List of public IP or IP ranges in CIDR Format | `list(string)` | <pre>[<br>  "198.208.0.0/16"<br>]</pre> | no |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_dbw_adls_ids"></a> [dbw\_adls\_ids](#input\_dbw\_adls\_ids) | List of ADLS Storage Account IDs | `list(string)` | n/a | yes |
| <a name="input_dbw_resource_object_id"></a> [dbw\_resource\_object\_id](#input\_dbw\_resource\_object\_id) | Application ID of Azure Databricks | `string` | `"ceffa7af-f110-4550-bf03-64fab66a2384"` | no |
| <a name="input_dbw_subnet_private_endpoint_id"></a> [dbw\_subnet\_private\_endpoint\_id](#input\_dbw\_subnet\_private\_endpoint\_id) | Subnet Id to create private endpoint for Databricks workspace | `string` | n/a | yes |
| <a name="input_dbw_subnet_private_name"></a> [dbw\_subnet\_private\_name](#input\_dbw\_subnet\_private\_name) | Private subnet name for Databricks compute | `string` | n/a | yes |
| <a name="input_dbw_subnet_private_nsg_id"></a> [dbw\_subnet\_private\_nsg\_id](#input\_dbw\_subnet\_private\_nsg\_id) | Network Security Group ID of private subnet of Databricks compute | `string` | n/a | yes |
| <a name="input_dbw_subnet_public_name"></a> [dbw\_subnet\_public\_name](#input\_dbw\_subnet\_public\_name) | Public subnet name for Databricks host | `string` | n/a | yes |
| <a name="input_dbw_subnet_public_nsg_id"></a> [dbw\_subnet\_public\_nsg\_id](#input\_dbw\_subnet\_public\_nsg\_id) | Network Security Group ID of public subnet of Databricks host | `string` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | n/a | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | category of logs to be collected see https://learn.microsoft.com/en-us/azure/databricks/administration-guide/account-settings/azure-diagnostic-logs#events | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "accounts",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "clusters",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "instancePools",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "jobs",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "notebook",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "unityCatalog",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": "workspace",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | Whether or not to send logs and metrics to a Log Analytics Workspace | `bool` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_group_users"></a> [group\_users](#input\_group\_users) | A map to map users to groups | <pre>map(object({<br>    group_key = string<br>    user_key  = string<br>  }))</pre> | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | A map to create multiple databricks workspace groups | <pre>map(object({<br>    display_name               = string<br>    allow_cluster_create       = bool<br>    allow_instance_pool_create = bool<br>    databricks_sql_access      = bool<br>    workspace_access           = bool<br>  }))</pre> | `{}` | no |
| <a name="input_is_customer_managed_key_enabled"></a> [is\_customer\_managed\_key\_enabled](#input\_is\_customer\_managed\_key\_enabled) | Is customer managed key enabled | `bool` | `false` | no |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Location prefix of the azure resource group | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled\_diagnostics is true | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for the resource | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | A map to create multiple databricks workspace users | <pre>map(object({<br>    user_name    = string<br>    display_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | VNET ID of where Databricks workspace should be injected | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbw_id"></a> [dbw\_id](#output\_dbw\_id) | Databricks Workspace ID |
| <a name="output_dbw_url"></a> [dbw\_url](#output\_dbw\_url) | Databricks Workspace URL |
