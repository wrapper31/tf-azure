variable "resource_group_name" {
  description = "(Required) Resource Group Name under which the vm will be created"
  type        = string
}

variable "name_prefix" {
  description = "(Required) Virtual VM name prefix"
  type        = string
}

variable "descriptor" {
  description = "(Required) Virtual VM descriptor"
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags attached to Virtual machine"
  type        = map(string)
  default     = {}
}

variable "os_disk_image" {
  description = "(Optional) Specifies the os disk image of the virtual machine"
  type        = map(string)
  default = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "19h2-pro-g2"
    version   = "latest"
  }
}

variable "os_disk_storage_account_type" {
  description = "(Optional) Specifies the storage account type of the os disk of the virtual machine"
  type        = string
  default     = "StandardSSD_LRS"

  validation {
    condition     = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS", "Standard_LRS"], var.os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid"
  }
}

variable "size" {
  description = "Specifies the size of the virtual machine"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "subnet_id" {
  description = "(Required) Specifies the resource id of the subnet hosting the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "(Required) Specifies the username of the virtual machine"
  type        = string
  default     = "azure-user"
}

variable "admin_password_name" {
  description = "(Required) Specifies the name of the password in the key vault"
  type        = string
  default     = "windows-vm-password"
}

variable "create_password" {
  description = "Specifies whether to create a password in the key vault"
  type        = bool
  default     = true
}

variable "boot_diagnostics_storage_account" {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor"
  type        = string
  default     = null
}

variable "enable_windows_server" {
  description = "Whether it is Windows VM or Windows Server"
  type        = bool
  default     = false
}

variable "install_az_cli" {
  description = "Whether to install Azure CLI"
  type        = bool
  default     = true
}

variable "install_kubectl" {
  description = "Whether to install kubectl"
  type        = bool
  default     = true
}

variable "key_vault_id" {
  description = "(Required) Key Vault ID"
  type        = string
}

variable "key_vault_name" {
  description = "(Required) Name of key vault"
  type        = string
}

variable "log_analytics_enabled" {
  description = "Enable sending of logs to Log Analytics Workspace"
  type        = bool
  default     = false
}

variable "log_analytics_resource_id" {
  description = "(Required) Refers to log analytics log_analytics_resource_id"
  type        = string
  default     = null
}

variable "diagnostic_logs" {
  description = "A list of logs to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/virtual-machines/monitor-vm-reference"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = []
}

variable "diagnostic_metrics" {
  description = "A list of metrics to send to the Log Analytics Workspace see https://learn.microsoft.com/en-us/azure/virtual-machines/monitor-vm-reference"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [{
    category          = "AllMetrics"
    enabled           = true
    retention_days    = 30
    retention_enabled = true
  }]
}

variable "prevent_destroy" {
  description = "Prevent the resource from being destroyed by Terraform by creating a lock, can be bypassed by manually deleting the lock"
  type        = bool
  default     = true
}

variable "install_vcdm" {
  description = "Whether to install vcdm client"
  type        = bool
  default     = false
}
