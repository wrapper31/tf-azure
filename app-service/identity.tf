# Grant the azure application service access to our keyvault to read the certificate data
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate#:~:text=If%20using%20key_vault_secret_id,every%20AAD%20Tenant%3A
# https://azure.github.io/AppService/2016/05/24/Deploying-Azure-Web-App-Certificate-through-Key-Vault.html
# https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-certificate?tabs=apex%2Cportal#authorize-app-service-to-read-from-the-vault
# This is optional as it requires an additional permission to read from Active Directory
# The value retrieved is the same across a tenant so in most cases the default (value from GM tenant) is sufficient
data "azuread_service_principal" "microsoft_web_app" {
  count          = var.read_azure_app_service_principal_id ? 1 : 0
  application_id = "abfa0a7c-a6b6-4736-8310-5855508787cd"
}

resource "azurerm_role_assignment" "appservice_secrets_user" {
  count                = var.key_vault_id != null ? 1 : 0
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.read_azure_app_service_principal_id ? data.azuread_service_principal.microsoft_web_app[0].id : var.azure_app_service_principal_id
}
