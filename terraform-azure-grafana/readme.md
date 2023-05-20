# Azure Managed Grafana
Terraform module for provisioning Azure managed grafana by following SDV standards

## Name Format

- `a${local.asms}${local.environment_vars.locals.env}${local.region_vars.locals.location_prefix}amg${var.descriptor}`

## Usage

The below code block provides minimal example configurations required to use this module. Refer input variable for all available options

```hcl

module "grafana" {
  source                        = "github.com/GM-SDV/azure-tf-modules.git//terraform-azure-grafana"
  descriptor                    = "test"
  asms                          = "a210298"
  name_prefix_no_dash           = "a210298d2musea2"
  location                      = "eastus2"
  log_analytics_resource_id     = "/subscriptions/b89bf714-9c05-4cbc-859d-01def0be0c46/resourceGroups/a210298-d2-musea2-rg-global/providers/Microsoft.OperationalInsights/workspaces/a210298-d2-musea2-log-global"
  resource_group_name           = "a210298-d2-musea2-rg-global"
  public_network_access_enabled = true
  pvtnet_access_enabled         = false
  grafana_role_assignment = {
    # 210298-ucp-infra-contributor
    "ba595a11-d8f3-4254-b8dd-321b6a9df9a8" = ["Grafana Admin"]
  }
}

```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.54 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.54 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana_dashboard_monitoring_reader"></a> [grafana\_dashboard\_monitoring\_reader](#module\_grafana\_dashboard\_monitoring\_reader) | ../terraform-azurerm-role-assignment | n/a |
| <a name="module_grafana_role_assignment"></a> [grafana\_role\_assignment](#module\_grafana\_role\_assignment) | ../terraform-azurerm-role-assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_dashboard_grafana.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dashboard_grafana) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `string` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | descriptor of the azure resource group | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | category of logs to be collected see https://learn.microsoft.com/en-us/azure/databricks/administration-guide/account-settings/azure-diagnostic-logs#events | <pre>set(object({<br>    category          = string<br>    category_group    = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": null,<br>    "category_group": "allLogs",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  },<br>  {<br>    "category": null,<br>    "category_group": "audit",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `bool` | `true` | no |
| <a name="input_monitoring_reader_scope"></a> [monitoring\_reader\_scope](#input\_monitoring\_reader\_scope) | List of Resource ID for the monitoring reader role scope | `list(string)` | `[]` | no |
| <a name="input_grafana_role_assignment"></a> [grafana\_role\_assignment](#input\_grafana\_role\_assignment) | List of Role (Reader, Contributor) to be assigned at the grafana | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group | `string` | n/a | yes |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | workspace id for log analytics | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix name.i.e. a210298-s1-musea2 | `string` | n/a | yes |
| <a name="input_name_prefix_no_dash"></a> [name\_prefix\_no\_dash](#input\_name\_prefix\_no\_dash) | The prefix name wothout dashes.i.e. a210298s1musea2 | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Public endpoints allow access to this resource through the internet using a public IP address. | `bool` | `false` | no |
| <a name="input_pvtnet_access_enabled"></a> [pvtnet\_access\_enabled](#input\_pvtnet\_access\_enabled) | Private Newtwork Access - true = allow / false = deny | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet id of the private endpoint tied to grafana | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_id"></a> [grafana\_id](#output\_grafana\_id) | Azure grafana resource id |
| <a name="output_grafana_url"></a> [grafana\_url](#output\_grafana\_url) | Azure grafana url |
