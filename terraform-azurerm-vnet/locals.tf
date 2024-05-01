locals {
  environment_type = substr(var.env, 0, 1) == "p" ? "prod" : "devtest"

  # Firewall
  firewall_ips = {
    "devtest" = {
      "musea1" = "x.x.x.x"
      "musea2" = "XXX.XX.XX.X"
     
    },
    "prod" = {
      "musea1" = "x.x.x.x"
    }
  }
  calculated_firewall_ip = lookup(lookup(local.firewall_ips, local.environment_type, {}), var.location_prefix, null)
  firewall_ip            = coalesce(var.firewall_ip_override, local.calculated_firewall_ip)

  cidr_ip_address = zipmap(toset(var.vnet_cidr_ranges), range(length(var.vnet_cidr_ranges)))

  # Peering

  devtest_environment_code             = var.location_prefix == "musea2" && var.devtest_environment_code_override ? "dt1" : "dt2"
  conditional_devtest_environment_code = local.devtest_environment_code == "dt2" ? "dt1" : "dt2"
  hub_environment_code                 = local.environment_type == "prod" ? "p1" : local.devtest_environment_code
  hub_resource_prefix                  = "asms-${local.hub_environment_code}-${var.location_prefix}"
  hub_resource_group_name              = coalesce(var.hub_resource_group_name_override, "${local.hub_resource_prefix}-rg001")
  hub_virtual_network_name             = coalesce(var.hub_virtual_network_name_override, "${local.hub_resource_prefix}-vnet001")
  hub_route_table_name                 = coalesce(var.hub_route_table_name_override, "${local.hub_resource_prefix}-rt003")
  dns_zone_network_link_hub_name       = "${var.resource_prefix}-pdnsvnl-to-hub"
  # DNS
  default_dns_vnet_info = {
    (var.hub_network_link_default_custom_name == null ? "${local.hub_environment_code}" : var.hub_network_link_default_custom_name) = {
      virtual_network_name = local.hub_virtual_network_name
      resource_group_name  = local.hub_resource_group_name
    }
  }
  conditional_dns_vnet_info = var.location_prefix == "musea2" && local.environment_type == "devtest" ? {
    var.hub_network_link_custom_name == null ? "${local.conditional_devtest_environment_code}" : var.hub_network_link_custom_name = {
      virtual_network_name = "asms-${local.conditional_devtest_environment_code}-musea2-vnet001"
      resource_group_name  = "asms-${local.conditional_devtest_environment_code}-musea2-rg001"
    }
  } : {}
  dns_vnet_info = merge(
    local.default_dns_vnet_info,
    local.conditional_dns_vnet_info,
    var.additional_dns_vnet_info
  )
  dns_suffix            = local.environment_type == "prod" ? "azp.xx.com" : "azdt.xx.com"
  private_dns_zone_name = "${var.env}.a${var.asms}.${var.location_prefix}.${local.dns_suffix}"
}