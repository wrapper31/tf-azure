<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kusto_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database) | resource |
| [azurerm_kusto_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kusto_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adx_cluster"></a> [adx\_cluster](#input\_adx\_cluster) | ADX cluster to create the database in | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_cache_days"></a> [cache\_days](#input\_cache\_days) | Days that the data that should be kept in cache for fast queries | `number` | `5` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | name of the ADX database to create | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resource group where the ADX Cluster will be created | `string` | n/a | yes |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Days to keep data | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | the created database |
<!-- END_TF_DOCS -->
