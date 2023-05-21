<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.2.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ../terraform-azure-key-vault | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/resource_group) | resource |
| [azurerm_service_plan.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acronym"></a> [acronym](#input\_acronym) | ASMS Acronym | `string` | n/a | yes |
| <a name="input_alternate_innovation_owner_email"></a> [alternate\_innovation\_owner\_email](#input\_alternate\_innovation\_owner\_email) | n/a | `string` | n/a | yes |
| <a name="input_alternate_operations_owner_email"></a> [alternate\_operations\_owner\_email](#input\_alternate\_operations\_owner\_email) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_subnet_id"></a> [app\_gateway\_subnet\_id](#input\_app\_gateway\_subnet\_id) | Subnet ID for App Gateway | `string` | n/a | yes |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_asms_status"></a> [asms\_status](#input\_asms\_status) | n/a | `string` | n/a | yes |
| <a name="input_business_function"></a> [business\_function](#input\_business\_function) | n/a | `string` | n/a | yes |
| <a name="input_business_sub_function"></a> [business\_sub\_function](#input\_business\_sub\_function) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_innovation_owner_email"></a> [innovation\_owner\_email](#input\_innovation\_owner\_email) | n/a | `string` | n/a | yes |
| <a name="input_key_vault_subnet_id"></a> [key\_vault\_subnet\_id](#input\_key\_vault\_subnet\_id) | Subnet ID for Key Vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_operations_owner_email"></a> [operations\_owner\_email](#input\_operations\_owner\_email) | n/a | `string` | n/a | yes |
| <a name="input_owning_organization"></a> [owning\_organization](#input\_owning\_organization) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | n/a |
| <a name="output_key_vault_identity_id"></a> [key\_vault\_identity\_id](#output\_key\_vault\_identity\_id) | n/a |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | n/a |
<!-- END_TF_DOCS -->
