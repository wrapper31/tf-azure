# Ultifi Connected Platform Deployment Module
Terraform module for deploying Ultifi Connected Platform (UCP) to Microsoft Azure.

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
| <a name="module_aks"></a> [aks](#module\_aks) | ../terraform-azure-aks-acr-identity | n/a |
| <a name="module_app_services"></a> [app\_services](#module\_app\_services) | ../terraform-azure-app-service | n/a |
| <a name="module_application_gateway"></a> [application\_gateway](#module\_application\_gateway) | ../terraform-azure-application-gateway | n/a |
| <a name="module_cosmos_db"></a> [cosmos\_db](#module\_cosmos\_db) | ../terraform-azure-cosmos-db | n/a |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | ../terraform-azure-event-hub | n/a |
| <a name="module_function_apps"></a> [function\_apps](#module\_function\_apps) | ../terraform-azure-function-apps | n/a |
| <a name="module_iot_hub"></a> [iot\_hub](#module\_iot\_hub) | ../terraform-azure-iot-hub | n/a |
| <a name="module_service_bus"></a> [service\_bus](#module\_service\_bus) | ../terraform-azure-service-bus | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_certificate.tf_ucp](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/key_vault_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acronym"></a> [acronym](#input\_acronym) | ASMS Acronym | `string` | n/a | yes |
| <a name="input_aks_subnet_id"></a> [aks\_subnet\_id](#input\_aks\_subnet\_id) | Subnet ID for AKS | `string` | n/a | yes |
| <a name="input_app_gateway_subnet_id"></a> [app\_gateway\_subnet\_id](#input\_app\_gateway\_subnet\_id) | Subnet ID for App Gateway | `string` | n/a | yes |
| <a name="input_app_service_subnet_id"></a> [app\_service\_subnet\_id](#input\_app\_service\_subnet\_id) | Subnet ID for App Service | `string` | n/a | yes |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_cosmos_db_subnet_id"></a> [cosmos\_db\_subnet\_id](#input\_cosmos\_db\_subnet\_id) | Subnet ID for Cosmos DB | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS Prefix | `string` | `"tfq"` | no |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_event_hub_subnet_id"></a> [event\_hub\_subnet\_id](#input\_event\_hub\_subnet\_id) | Subnet ID for Event Hub | `string` | n/a | yes |
| <a name="input_function_apps_subnet_id"></a> [function\_apps\_subnet\_id](#input\_function\_apps\_subnet\_id) | Subnet ID for Functions | `string` | n/a | yes |
| <a name="input_iot_hub_subnet_id"></a> [iot\_hub\_subnet\_id](#input\_iot\_hub\_subnet\_id) | Subnet ID for IoT Hub | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | n/a | `string` | n/a | yes |
| <a name="input_key_vault_identity_id"></a> [key\_vault\_identity\_id](#input\_key\_vault\_identity\_id) | n/a | `string` | n/a | yes |
| <a name="input_key_vault_subnet_id"></a> [key\_vault\_subnet\_id](#input\_key\_vault\_subnet\_id) | Subnet ID for Key Vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Location of the azure resource group. | `string` | n/a | yes |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | Max number of K8S nodes to provision. | `string` | `4` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | Min number of K8S nodes to provision. | `string` | `1` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The number of K8S nodes to provision. | `string` | `1` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The size of each node. | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | ID of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_service_bus_subnet_id"></a> [service\_bus\_subnet\_id](#input\_service\_bus\_subnet\_id) | Subnet ID for Service Bus | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
