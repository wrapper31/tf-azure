This module creates a Virtual Network for an environment. The VNet will be created in accordance with  standards and peered with the hub network. Any other setup required in the hub will be taken care of. A private DNS zone is also created and linked with the VNets.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.21.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.21.0 |
| <a name="provider_azurerm.hub"></a> [azurerm.hub](#provider\_azurerm.hub) | >= 3.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_route.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.hub_to_spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.hub_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_dns_vnet_info"></a> [additional\_dns\_vnet\_info](#input\_additional\_dns\_vnet\_info) | Any additional hub VNets to link DNS to | <pre>map(object({<br>    virtual_network_name = string<br>    resource_group_name  = string<br>  }))</pre> | `{}` | no |
| <a name="input_asms"></a> [asms](#input\_asms) | ASMS Number | `number` | n/a | yes |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | ID of the DDOS protection plan | `string` | `"/subscriptions/e06b3992-dbb3-45e8-bd7a-b8b557bb8c94/resourceGroups/a203578-p1-musea2-rg001-ddos/providers/Microsoft.Network/ddosProtectionPlans/a203578-p1-musea2-ddosp001"` | no |
| <a name="input_devtest_environment_code_override"></a> [devtest\_environment\_code\_override](#input\_devtest\_environment\_code\_override) | whether to override default devtest environment code | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_firewall_ip_override"></a> [firewall\_ip\_override](#input\_firewall\_ip\_override) | IP of the firewall to serve as a DNS server, overrides the calculated default | `string` | `null` | no |
| <a name="input_hub_network_link_custom_name"></a> [hub\_network\_link\_custom\_name](#input\_hub\_network\_link\_custom\_name) | The name of the dns zone hub network link | `string` | `null` | no |
| <a name="input_hub_network_link_default_custom_name"></a> [hub\_network\_link\_default\_custom\_name](#input\_hub\_network\_link\_default\_custom\_name) | The name of the dns zone hub network link | `string` | `null` | no |
| <a name="input_hub_resource_group_name_override"></a> [hub\_resource\_group\_name\_override](#input\_hub\_resource\_group\_name\_override) | Name of the hub resource group, overrides the calculated default | `string` | `null` | no |
| <a name="input_hub_route_table_name_override"></a> [hub\_route\_table\_name\_override](#input\_hub\_route\_table\_name\_override) | Name of the hub route table, overrides the calculated default | `string` | `null` | no |
| <a name="input_hub_to_spoke_peering_name"></a> [hub\_to\_spoke\_peering\_name](#input\_hub\_to\_spoke\_peering\_name) | Hub to spoke peering nanme | `string` | `null` | no |
| <a name="input_hub_virtual_network_name_override"></a> [hub\_virtual\_network\_name\_override](#input\_hub\_virtual\_network\_name\_override) | Name of the hub virtual network, overrides the calculated default | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the azure resources | `string` | n/a | yes |
| <a name="input_location_prefix"></a> [location\_prefix](#input\_location\_prefix) | Prefix for the location of the resource eg., region code | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | `null` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix for all resource names | `string` | n/a | yes |
| <a name="input_spoke_to_hub_peering_name"></a> [spoke\_to\_hub\_peering\_name](#input\_spoke\_to\_hub\_peering\_name) | Spoke to hub peering nanme | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tag name (key=value) | `map(string)` | `{}` | no |
| <a name="input_vnet_cidr_ranges"></a> [vnet\_cidr\_ranges](#input\_vnet\_cidr\_ranges) | CIDR IP range for the spoke VNet | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone"></a> [dns\_zone](#output\_dns\_zone) | The azurerm\_private\_dns\_zone resource for the created private DNS zone |
| <a name="output_environment_private_dns_zone_name"></a> [environment\_private\_dns\_zone\_name](#output\_environment\_private\_dns\_zone\_name) | The name of the private DNS zone for the environment |
| <a name="output_environment_private_dns_zone_resource_group"></a> [environment\_private\_dns\_zone\_resource\_group](#output\_environment\_private\_dns\_zone\_resource\_group) | The name of the resource group where the private DNS zone is created |
| <a name="output_firewall_ip"></a> [firewall\_ip](#output\_firewall\_ip) | The IP of the firewall to use with this VNet |
| <a name="output_hub_to_spoke_peering"></a> [hub\_to\_spoke\_peering](#output\_hub\_to\_spoke\_peering) | The azurerm\_virtual\_network\_peering resource for the hub to spoke peering |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The azurerm\_resource\_group resource where the rest of the resources are created |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group with the VNet and peering resources |
| <a name="output_spoke_to_hub_peering"></a> [spoke\_to\_hub\_peering](#output\_spoke\_to\_hub\_peering) | The azurerm\_virtual\_network\_peering resource for the spoke to hub peering |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the created VNet |
| <a name="output_virtual_network_resource_group_name"></a> [virtual\_network\_resource\_group\_name](#output\_virtual\_network\_resource\_group\_name) | The name of the resource group where the VNet is created |
| <a name="output_vnet"></a> [vnet](#output\_vnet) | The azurerm\_virtual\_network resource for the created spoke VNet |
<!-- END_TF_DOCS -->