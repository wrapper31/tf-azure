locals {
  hostnames = [
    "grpc-proxy",
    "pet-app"
  ]
}

resource "azurerm_dns_a_record" "grpcproxy" {
  for_each            = toset(local.hostnames)
  name                = "${each.key}.${var.env}"
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.aks_ip]
}
