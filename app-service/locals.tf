locals {
  default_site_config = {
    always_on = "true"
  }

  auth_settings = merge(
    {
      enabled                       = true
      issuer                        = null
      token_store_enabled           = false
      unauthenticated_client_action = "RedirectToLoginPage"
      default_provider              = "AzureActiveDirectory"
      //allowed_external_redirect_urls = []
      active_directory = null
    },
  var.auth_settings)

  auth_settings_active_directory = merge(
    {
      client_id = null
      // client_secret    = null
      //allowed_audiences = []
    },

  local.auth_settings.active_directory == null ? local.auth_settings_ad_default : var.auth_settings.active_directory)

  auth_settings_ad_default = {
    client_id = null
    // client_secret    = null
    //allowed_audiences = []
  }

}
