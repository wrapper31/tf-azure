
resource "azurerm_private_dns_a_record" "this" {
  for_each            = toset(var.hostnames)
  name                = each.key
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.dns_resource_group_name
  ttl                 = var.microservices_dns_ttl
  records             = [var.nginx_ingress_ip]
}
