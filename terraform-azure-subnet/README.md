## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | >= 0.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.subnet](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | n/a | `string` | n/a | yes |
| <a name="input_cidr_address_prefix"></a> [cidr\_address\_prefix](#input\_cidr\_address\_prefix) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | Delegate subnet to a dedicated service.<br>    Example:<br>      [{<br>        name = "delegation"<br>        properties = {<br>          serviceName = "Microsoft.ContainerInstance/containerGroups"<br>        }<br>      }<br>      ] | <pre>set(object({<br>    name = string<br>    properties = object({<br>      serviceName = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | n/a | `string` | n/a | yes |
| <a name="input_enable_deny_rule"></a> [enable\_deny\_rule](#input\_enable\_deny\_rule) | to enable deny all rule | `bool` | `true` | no |
| <a name="input_firewall_ip"></a> [firewall\_ip](#input\_firewall\_ip) | Pass in Dev or Prod respective Firewall IP. | `string` | n/a | yes |
| <a name="input_inbound_connections"></a> [inbound\_connections](#input\_inbound\_connections) | n/a | <pre>set(object({<br>    address_space              = string<br>    port_range                 = string<br>    destination_address_prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_next_hop_is_to_vappliance"></a> [next\_hop\_is\_to\_vappliance](#input\_next\_hop\_is\_to\_vappliance) | to pass the route to firewall IP (Virtual Appliance) | `bool` | `true` | no |
| <a name="input_outbound_connections"></a> [outbound\_connections](#input\_outbound\_connections) | n/a | <pre>set(object({<br>    address_space = string<br>    port_range    = string<br>  }))</pre> | `[]` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | GM network security mandates this parameter to be set as Enabled - https://colibri.opi.gm.com/documents/azure-cloud/networking/network-security#required-inbound-nsg-rules | `string` | `"Enabled"` | no |
| <a name="input_private_link_service_network_policies"></a> [private\_link\_service\_network\_policies](#input\_private\_link\_service\_network\_policies) | GM network security mandates this parameter to be set as Enabled - https://colibri.opi.gm.com/documents/azure-cloud/networking/network-security#required-inbound-nsg-rules | `string` | `"Enabled"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | The predominant resource type in the subnet | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Manages the routes for this subnet<br>    Example:<br>      { name = "IothubRoute",<br>        address\_prefix = "AzureIoTHub",<br>        next\_hop\_type = "Internet"<br>      }] | <pre>list(object({<br>    name           = string<br>    address_prefix = string<br>    next_hop_type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | n/a | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | route\_table ID- output to oher module subsystems |
| <a name="output_route_table_name"></a> [route\_table\_name](#output\_route\_table\_name) | route\_table Name-output to oher module subsystems |
| <a name="output_route_table_rg_name"></a> [route\_table\_rg\_name](#output\_route\_table\_rg\_name) | route\_table resource group name- output to oher module subsystems |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Network Subnet ID |
| <a name="output_subnet_nsg_id"></a> [subnet\_nsg\_id](#output\_subnet\_nsg\_id) | Network Security group ID |
| <a name="output_subnet_nsg_name"></a> [subnet\_nsg\_name](#output\_subnet\_nsg\_name) | Network Security group name |
| <a name="output_subnet_nsg_rg_name"></a> [subnet\_nsg\_rg\_name](#output\_subnet\_nsg\_rg\_name) | Network Security group resource group name |
