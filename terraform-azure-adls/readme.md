<!-- BEGIN_TF_DOCS -->
## Requirements

Ensure to point to UAP subscription

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.uap_dbx_adls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_private_endpoint.uap_a213222_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

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
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | `Storage Account Tier - Standard, Premium` | `string` | n/a | yes |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\account\_replication\_type) | `Storage Account Tier - LRS,GRS,RAGRS,ZRS,GZRS,RAGZRS` | `string` | n/a | yes |
| <a name="input_allow_ip_rules"></a> [allow\_ip\_rules](#input\allow\_ip\_rules) | `List of whitelist IPs` | `list(string)` | n/a | yes |
| <a name="input_allowed_subnet_ids"></a> [allowed\_subnet\_ids](#input\allowed\_subnet\_ids) | `List of allowed Subnet Ids for storage account network access` | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_adls_storage_account"></a> [adls\_storage\_account](#output\_adls\_storage\_account) | n/a |
| <a name="output_adls_private_endpoint"></a> [adls\_private\_endpoint](#output\_adls\_private\_endpoint) | n/a |
<!-- END_TF_DOCS -->
