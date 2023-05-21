<!-- BEGIN_TF_DOCS -->
## Requirements

Ensure necessary VNet, Subnets, Azure Firewall, Databricks, Storage Accounts, Key Vaults are in place

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules


## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |
| [azurerm_data_factory_integration_runtime_self_hosted.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_self_hosted) | resource |
| [azurerm_data_factory_integration_runtime_azure.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure) | resource |
| [azurerm_private_endpoint.adfy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.adfp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_role_assignment.sbdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dbwrole](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\env) | `Name of the deployment environment` | `string` | n/a | yes |
| <a name="input_asms"></a> [asms](#input\asms) | `ASMS Number` | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | `Location of the azure resource group` | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | `Location prefix of the azure resource group` | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | `Name of the resource group` | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | `ID of the subnet for the storage account endpoint` | `string` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | `Descriptor` | `string` | n/a | yes |
| <a name="input_allow_ip_rules"></a> [allow\_ip\_rules](#input\_allow\_ip\_rules) | `List of public IP or IP ranges in CIDR Format` | `list(string)` | n/a | no |
| <a name="input_managed_virtual_network_enabled"></a> [managed\_virtual\_network\_enabled](#input\managed\_virtual\_network\_enabled) | `Is Managed Virtual Network enabled for ADF` | `bool` | n/a | no |
| <a name="input_public_network_enabled"></a> [public\_network\_enabled](#input\public\_network\_enabled) | `Is the Data Factory visible to the public network?` | `bool` | n/a | no |
| <a name="input_github_configuration"></a> [github\_configuration](#input\github\_configuration) | `An input object to define the settings for connecting to GitHub. You must log in to the Data Factory management UI to complete the authentication to the GitHub repository.` | `object({})` | n/a | no |
| <a name="input_global_parameters"></a> [global\_parameters](#input\global\_parameters) | `An input object to define a global parameter. Accepts multiple entries` | `any` | n/a | no |
| <a name="input_self_hosted_integration_runtime"></a> [self\_hosted\_integration\_runtime](#input\self\_hosted\_integration\_runtime) | `Map Object to define any Azure self hosted Integration Runtime` | `map(object(string, string)` | n/a | no |
| <a name="input_azure_integration_runtime"></a> [azure\_hosted\_integration\_runtime](#input\azure\_hosted\_integration\_runtime) | `Map Object to define any Azure Integration Runtime nodes that required` | `map(object(string, string)` | n/a | no |
| <a name="input_adf_adls_idss"></a> [adf\_adls\_ids](#input\adf\_adls\_ids) | `List of ADLS Storage Account IDs` | `list(string)` | n/a | yes |
| <a name="input_adf_dbw_id"></a> [adf\_dbw\_id](#input\_adf\_dbw\_id) | `Databricks Workspace ID` | `string` | n/a | yes |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id_) | `Key Vault ID` | `string` | n/a | yes |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\enable\_diagnostics) | `To enable diagnostics logging` | `bool` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\log\_analytics\_resource\_id) | `Log Analytics Workspace ID` | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic_logs](#input\diagnostic\_logs) | `List of Diagnostic logging cateogries` | `set(object(string, object)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_adf_id"></a> [adf\_id](#output\_adf\_id) | Azure Data Factory Id |
| <a name="output_adf_name"></a> [adf\_id](#output\_adf\_name) | Azure Data Factory Name |
| <a name="output_adf_global_paramaters"></a> [adf\_global\_paramaters](#output\adf\_global\_paramaters) | List of global parameters |
| <a name="output_shir"></a> [shir](#output\_shir) | ADF Self Hosted Integration Runtime |
<!-- END_TF_DOCS -->
