resource "azurerm_windows_virtual_machine" "this" {
  name                  = "${var.name_prefix}-vm-${var.descriptor}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = var.size
  computer_name         = "vm-${var.descriptor}"
  admin_username        = var.admin_username
  admin_password        = var.create_password ? random_password.admin[0].result : data.azurerm_key_vault_secret.admin[0].value

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                 = "${var.name_prefix}-win-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    offer     = lookup(var.os_disk_image, "offer", null)
    publisher = lookup(var.os_disk_image, "publisher", null)
    sku       = lookup(var.os_disk_image, "sku", null)
    version   = lookup(var.os_disk_image, "version", null)
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_management_lock" "prevent_destroy" {
  count = var.prevent_destroy ? 1 : 0

  name       = "PreventDestroy"
  scope      = azurerm_windows_virtual_machine.this.id
  lock_level = "CanNotDelete"
  notes      = "Care should be taken when deleting resources with data."

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "${var.name_prefix}-AADLoginForWindows"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

locals {
  az_cli_command         = "powershell -command $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\\AzureCLI.msi;"
  kubectl_command        = "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); choco install -y kubernetes-cli;"
  windows_server_command = "Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername); Add-WindowsFeature Web-Asp-Net45; Add-WindowsFeature NET-Framework-45-Core; Add-WindowsFeature Web-Net-Ext45; Add-WindowsFeature Web-ISAPI-Ext; Add-WindowsFeature Web-ISAPI-Filter; Add-WindowsFeature Web-Mgmt-Console; Add-WindowsFeature Web-Scripting-Tools; Add-WindowsFeature Search-Service; Add-WindowsFeature Web-Filtering; Add-WindowsFeature Web-Basic-Auth; Add-WindowsFeature Web-Windows-Auth; Add-WindowsFeature Web-Default-Doc; Add-WindowsFeature Web-Http-Errors; Add-WindowsFeature Web-Static-Content; Install-WindowsFeature RDS-Licensing -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RDS-RD-Server -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RDS-Licensing-UI -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RSAT-RDS-Licensing-Diagnosis-UI -IncludeAllSubFeature -IncludeManagementTools;"
  vcdm_command           = "\"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${filebase64("${path.module}/vcdm.ps1")}')) | Out-File -filepath vcdm.ps1 \"&& powershell -File vcdm.ps1\""
  custom_command         = "${var.install_az_cli ? local.az_cli_command : ""} ${var.install_kubectl ? local.kubectl_command : ""} ${var.enable_windows_server ? local.windows_server_command : ""} ${var.install_vcdm ? local.vcdm_command : ""}"
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  count = local.custom_command != "" ? 1 : 0

  name                 = "${var.name_prefix}-custom-script"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = jsonencode({
    "commandToExecute" : local.custom_command
  })

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}
