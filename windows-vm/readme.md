## Resources

## This resource can be use to create Windows VM or Window Server 
## Following extention are added 
## Windows VM  =  Azure CLi + IIS Server
## Windows Server = Azure CLi + IIS Server + RDS 
## Pass following parameter from terragrunt to create Windows Server.  By default, it will create Windows VM.
  ## for windows server  enable below properties
  enable_windows_server = true
  os_disk_image = { "publisher" = "MicrosoftWindowsServer"
    "offer"   = "WindowsServer"
    "sku"     = "2019-Datacenter"
    "version" = "latest"
  }

https://github.com/claranet/terraform-azurerm-windows-vm/tree/master

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.39.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.46.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_disk_encryption_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_role_assignment.encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_machine_extension.aad_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.az_cli_install](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.daa_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.monitor_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.msmonitor_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.windows_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_key_vault_secret.admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password_name"></a> [admin\_password\_name](#input\_admin\_password\_name) | (Required) Specifies the name of the password in the key vault | `string` | `"windows-vm-password"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) Specifies the username of the virtual machine | `string` | `"azure-user"` | no |
| <a name="input_boot_diagnostics_storage_account"></a> [boot\_diagnostics\_storage\_account](#input\_boot\_diagnostics\_storage\_account) | (Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor | `string` | `null` | no |
| <a name="input_create_password"></a> [create\_password](#input\_create\_password) | Specifies whether to create a password in the key vault | `bool` | `true` | no |
| <a name="input_descriptor"></a> [descriptor](#input\_descriptor) | (Required) Virtual VM descriptor | `string` | n/a | yes |
| <a name="input_diagnostic_logs"></a> [diagnostic\_logs](#input\_diagnostic\_logs) | A list of logs to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/event-hubs/monitor-event-hubs-reference#resource-logs | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | `[]` | no |
| <a name="input_diagnostic_metrics"></a> [diagnostic\_metrics](#input\_diagnostic\_metrics) | value is a list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/aks/monitor-aks-reference#metrics | <pre>set(object({<br>    category          = string<br>    enabled           = bool<br>    retention_enabled = bool<br>    retention_days    = number<br>  }))</pre> | <pre>[<br>  {<br>    "category": "AllMetrics",<br>    "enabled": true,<br>    "retention_days": 30,<br>    "retention_enabled": true<br>  }<br>]</pre> | no |
| <a name="input_enable_log_analytics"></a> [enable\_log\_analytics](#input\_enable\_log\_analytics) | Whether or not to enable log analytics | `bool` | `false` | no |
| <a name="input_enable_windows_server"></a> [enable\_windows\_server](#input\_enable\_windows\_server) | Whether it is Windows VM or Windows Server | `bool` | `false` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | (Required) Key Vault ID | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | (Required) Name of key vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the location of the virtual machine | `string` | n/a | yes |
| <a name="input_log_analytics_primary_shared_key"></a> [log\_analytics\_primary\_shared\_key](#input\_log\_analytics\_primary\_shared\_key) | (Required) Refers to log analytics primary\_shared\_key | `string` | `null` | no |
| <a name="input_log_analytics_resource_id"></a> [log\_analytics\_resource\_id](#input\_log\_analytics\_resource\_id) | (Required) Refers to log analytics log\_analytics\_resource\_id | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) Refers to log analytics workspace\_id | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Required) Virtual VM name prefix | `string` | n/a | yes |
| <a name="input_os_disk_image"></a> [os\_disk\_image](#input\_os\_disk\_image) | (Optional) Specifies the os disk image of the virtual machine | `map(string)` | <pre>{<br>  "offer": "Windows-10",<br>  "publisher": "MicrosoftWindowsDesktop",<br>  "sku": "19h2-pro-g2",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | (Optional) Specifies the storage account type of the os disk of the virtual machine | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group Name under which the vm will be created | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Specifies the size of the virtual machine | `string` | `"Standard_DS1_v2"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Specifies the resource id of the subnet hosting the virtual machine | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags attached to Virtual machine | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_ecryption_managed_id"></a> [disk\_ecryption\_managed\_id](#output\_disk\_ecryption\_managed\_id) | Disk encryption set identity ID |
| <a name="output_encryption_key_url"></a> [encryption\_key\_url](#output\_encryption\_key\_url) | Encryption key ID |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID associated with this Managed Service Identity. |
| <a name="output_nic_id"></a> [nic\_id](#output\_nic\_id) | Network Interface ID- output to oher module subsystems |
| <a name="output_nic_name"></a> [nic\_name](#output\_nic\_name) | Network Interface Name-output to oher module subsystems |
| <a name="output_nic_rg_name"></a> [nic\_rg\_name](#output\_nic\_rg\_name) | Network Interface resource group name- output to oher module subsystems |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | Network Security Group ID- output to oher module subsystems |
| <a name="output_nsg_name"></a> [nsg\_name](#output\_nsg\_name) | Network Security Group Name-output to oher module subsystems |
| <a name="output_nsg_rg_name"></a> [nsg\_rg\_name](#output\_nsg\_rg\_name) | Network Security Group resource group name- output to oher module subsystems |
| <a name="output_windows_virtual_machine"></a> [windows\_virtual\_machine](#output\_windows\_virtual\_machine) | azurerm\_windows\_virtual\_machine resource |
| <a name="output_windows_vm_id"></a> [windows\_vm\_id](#output\_windows\_vm\_id) | windows\_vm ID- output to oher module subsystems |
| <a name="output_windows_vm_name"></a> [windows\_vm\_name](#output\_windows\_vm\_name) | windows\_vm Name-output to oher module subsystems |
| <a name="output_windows_vm_rg_name"></a> [windows\_vm\_rg\_name](#output\_windows\_vm\_rg\_name) | windows\_vm resource group name- output to oher module subsystems |
| <a name="output_windows_vm_user"></a> [windows\_vm\_user](#output\_windows\_vm\_user) | Windows Virtual Machine User Name- output to oher module subsystems |
<!-- END_TF_DOCS -->
