data "azurerm_application_insights" "this" {
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group_name
}

resource "azurerm_linux_function_app" "this" {
  name                          = "${var.name_prefix}-func-${var.descriptor}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = var.service_plan_id
  storage_account_name          = var.storage_account_name
  storage_uses_managed_identity = true
  https_only                    = true
  virtual_network_subnet_id     = var.outbound_subnet_id
  site_config {
    vnet_route_all_enabled = true
    application_stack {
      java_version   = var.java_version
      python_version = var.python_version
    }
  }
  app_settings = merge({
    "APPINSIGHTS_INSTRUMENTATIONKEY"   = data.azurerm_application_insights.this.connection_string
    "AzureWebJobsStorage__accountName" = var.storage_account_name
  }, var.app_settings)

  identity {
    type = "SystemAssigned"
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

data "azurerm_storage_account" "this" {
  resource_group_name = var.resource_group_name
  name                = var.storage_account_name
}
resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_linux_function_app.this.identity.0.principal_id
  depends_on           = [azurerm_linux_function_app.this]
  lifecycle {
    ignore_changes = [
      role_definition_id, principal_id
    ]
  }
}
resource "null_resource" "this" {
  depends_on = [azurerm_linux_function_app.this]
  provisioner "local-exec" {
    command = <<EOT
            az config set extension.use_dynamic_install=yes_without_prompt
            az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID  -o table
            az account set --subscription $ARM_SUBSCRIPTION_ID
            az functionapp config appsettings delete -g "${var.resource_group_name}"  -n "${azurerm_linux_function_app.this.name}" --setting-names AzureWebJobsStorage -o table
    EOT
  }
}
