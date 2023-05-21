<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.2.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks_subnet"></a> [aks\_subnet](#module\_aks\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_app_gateway_subnet"></a> [app\_gateway\_subnet](#module\_app\_gateway\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_app_service_subnet"></a> [app\_service\_subnet](#module\_app\_service\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_cosmos_db_subnet"></a> [cosmos\_db\_subnet](#module\_cosmos\_db\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_dev_portal_subnet"></a> [dev\_portal\_subnet](#module\_dev\_portal\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_event_grid_subnet"></a> [event\_grid\_subnet](#module\_event\_grid\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_event_hub_subnet"></a> [event\_hub\_subnet](#module\_event\_hub\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_function_apps_subnet"></a> [function\_apps\_subnet](#module\_function\_apps\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_iot_hub_subnet"></a> [iot\_hub\_subnet](#module\_iot\_hub\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_key_vault_subnet"></a> [key\_vault\_subnet](#module\_key\_vault\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_service_bus_subnet"></a> [service\_bus\_subnet](#module\_service\_bus\_subnet) | ../terraform-azure-subnet | n/a |
| <a name="module_storage_account_subnet"></a> [storage\_account\_subnet](#module\_storage\_account\_subnet) | ../terraform-azure-subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acronym"></a> [acronym](#input\_acronym) | ASMS Acronym | `string` | n/a | yes |
| <a name="input_aks_address_space"></a> [aks\_address\_space](#input\_aks\_address\_space) | CIDR IP range for AKS | `string` | n/a | yes |
| <a name="input_app_gateway_address_space"></a> [app\_gateway\_address\_space](#input\_app\_gateway\_address\_space) | CIDR IP range for App Gateway | `string` | n/a | yes |
| <a name="input_app_service_address_space"></a> [app\_service\_address\_space](#input\_app\_service\_address\_space) | CIDR IP range for App Service | `string` | n/a | yes |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_cosmos_db_address_space"></a> [cosmos\_db\_address\_space](#input\_cosmos\_db\_address\_space) | CIDR IP range for Cosmos DB | `string` | n/a | yes |
| <a name="input_dev_portal_address_space"></a> [dev\_portal\_address\_space](#input\_dev\_portal\_address\_space) | CIDR IP range for Dev Portal | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_event_grid_address_space"></a> [event\_grid\_address\_space](#input\_event\_grid\_address\_space) | CIDR IP range for Event Grid | `string` | n/a | yes |
| <a name="input_event_hub_address_space"></a> [event\_hub\_address\_space](#input\_event\_hub\_address\_space) | CIDR IP range for Event Hub | `string` | n/a | yes |
| <a name="input_functions_address_space"></a> [functions\_address\_space](#input\_functions\_address\_space) | CIDR IP range for Functions | `string` | n/a | yes |
| <a name="input_iot_hub_address_space"></a> [iot\_hub\_address\_space](#input\_iot\_hub\_address\_space) | CIDR IP range for IoT Hub | `string` | n/a | yes |
| <a name="input_key_vault_address_space"></a> [key\_vault\_address\_space](#input\_key\_vault\_address\_space) | CIDR IP range for Key Vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_service_bus_address_space"></a> [service\_bus\_address\_space](#input\_service\_bus\_address\_space) | CIDR IP range for Service Bus | `string` | n/a | yes |
| <a name="input_storage_account_address_space"></a> [storage\_account\_address\_space](#input\_storage\_account\_address\_space) | CIDR IP range for Storage Account | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_subnet_id"></a> [aks\_subnet\_id](#output\_aks\_subnet\_id) | n/a |
| <a name="output_app_gateway_subnet_id"></a> [app\_gateway\_subnet\_id](#output\_app\_gateway\_subnet\_id) | n/a |
| <a name="output_app_service_subnet_id"></a> [app\_service\_subnet\_id](#output\_app\_service\_subnet\_id) | n/a |
| <a name="output_cosmos_db_subnet_id"></a> [cosmos\_db\_subnet\_id](#output\_cosmos\_db\_subnet\_id) | n/a |
| <a name="output_dev_portal_subnet_id"></a> [dev\_portal\_subnet\_id](#output\_dev\_portal\_subnet\_id) | n/a |
| <a name="output_event_grid_subnet_id"></a> [event\_grid\_subnet\_id](#output\_event\_grid\_subnet\_id) | n/a |
| <a name="output_event_hub_subnet_id"></a> [event\_hub\_subnet\_id](#output\_event\_hub\_subnet\_id) | n/a |
| <a name="output_function_apps_subnet_id"></a> [function\_apps\_subnet\_id](#output\_function\_apps\_subnet\_id) | n/a |
| <a name="output_iot_hub_subnet_id"></a> [iot\_hub\_subnet\_id](#output\_iot\_hub\_subnet\_id) | n/a |
| <a name="output_key_vault_subnet_id"></a> [key\_vault\_subnet\_id](#output\_key\_vault\_subnet\_id) | n/a |
| <a name="output_service_bus_subnet_id"></a> [service\_bus\_subnet\_id](#output\_service\_bus\_subnet\_id) | n/a |
| <a name="output_storage_account_subnet_id"></a> [storage\_account\_subnet\_id](#output\_storage\_account\_subnet\_id) | n/a |
<!-- END_TF_DOCS -->
