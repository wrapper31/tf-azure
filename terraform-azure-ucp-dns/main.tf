module "dev_portal_dns" {
  source              = "../terraform-azure-dns-entry"
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  verification_id     = var.verification_id
  hostname            = "www.developer.${var.env}"
  target_name         = "${var.resource_prefix}-app-devportal.azurewebsites.net"
}
