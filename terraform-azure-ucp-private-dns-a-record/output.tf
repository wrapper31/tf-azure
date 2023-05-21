output "dns_fqdn" {
  description = "Full Qualified DNS Name-output to oher module subsystems"
  value       = values(azurerm_private_dns_a_record.this).*.fqdn
}
