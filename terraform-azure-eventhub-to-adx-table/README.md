<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kusto_cluster_managed_private_endpoint.adx_eh_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_managed_private_endpoint) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_script.create-tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_script) | resource |
| [azurerm_role_assignment.cluster_eh_receiver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [null_resource.endpoint_approval](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_eventhub_namespace.source_ingest_eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_kusto_cluster.adx_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kusto_cluster) | data source |
| [azurerm_kusto_database.adx_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kusto_database) | data source |
| [azurerm_user_assigned_identity.adx_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adx_cluster"></a> [adx\_cluster](#input\_adx\_cluster) | ADX cluster to create the database in | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>    identity_name       = string<br>  })</pre> | n/a | yes |
| <a name="input_adx_database_name"></a> [adx\_database\_name](#input\_adx\_database\_name) | name of the ADX database to send data to | `string` | n/a | yes |
| <a name="input_adx_target_table_name"></a> [adx\_target\_table\_name](#input\_adx\_target\_table\_name) | name of the ADX table to send data to | `string` | n/a | yes |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | Descriptor for the resource | `string` | n/a | yes |
| <a name="input_maximum_batching_timespan"></a> [maximum\_batching\_timespan](#input\_maximum\_batching\_timespan) | Maximum batching timespan for data ingestion, format 00:mm:ss.  Minimum 10 seconds, Maximum 30 minutes | `string` | `"00:05:00"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for all resource names | `string` | n/a | yes |
| <a name="input_source_event_hub_namespace"></a> [source\_event\_hub\_namespace](#input\_source\_event\_hub\_namespace) | Event hub namespace to connect to ADX | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_source_event_hubs"></a> [source\_event\_hubs](#input\_source\_event\_hubs) | List of source event hubs to create tables and mapping for | <pre>list(object({<br>    consumer_group_name = string<br>    event_hub_name      = string<br>    event_hub_id        = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
