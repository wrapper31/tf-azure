output "windows_vm_id" {
  description = "windows_vm ID- output to oher module subsystems"
  value       = azurerm_windows_virtual_machine.this.id
}

output "windows_vm_name" {
  description = "windows_vm Name-output to oher module subsystems"
  value       = azurerm_windows_virtual_machine.this.name
  sensitive   = true
}

output "windows_vm_rg_name" {
  description = "windows_vm resource group name- output to oher module subsystems"
  value       = azurerm_windows_virtual_machine.this.resource_group_name
}

output "windows_virtual_machine" {
  description = "azurerm_windows_virtual_machine resource"
  value       = azurerm_windows_virtual_machine.this
}

output "windows_vm_user" {
  description = "Windows Virtual Machine User Name- output to oher module subsystems"
  value       = var.admin_username
}

output "identity_principal_id" {
  description = "The Principal ID associated with this Managed Service Identity."
  value       = azurerm_windows_virtual_machine.this.identity.0.principal_id
}

output "disk_ecryption_managed_id" {
  description = "Disk encryption set identity ID"
  value       = azurerm_disk_encryption_set.this.identity[0].principal_id
}

output "encryption_key_url" {
  description = "Encryption key ID"
  value       = azurerm_key_vault_key.this.id
}

output "nic" {
  description = "The azurerm_network_interface resource attached to the VM"
  value       = azurerm_network_interface.this
}

output "nic_name" {
  description = "Name of the NIC attached to the VM"
  value       = azurerm_network_interface.this.name
}

output "nic_rg_name" {
  description = "Resource group of the NIC attached to the VM"
  value       = azurerm_network_interface.this.resource_group_name
}
