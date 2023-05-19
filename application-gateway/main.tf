resource "azurerm_web_application_firewall_policy" "this" {
  name                = "${var.name_prefix}-agwaf-${var.descriptor}"
  location            = var.location
  resource_group_name = var.resource_group_name

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      }
    }

    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "0.1"
    }
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

resource "azurerm_application_gateway" "this" {
  depends_on          = [azurerm_user_assigned_identity.this, azurerm_role_assignment.key_vault_access]
  name                = "${var.name_prefix}-agw-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.this.id
  zones               = ["1", "2", "3"]
  enable_http2        = true


  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration {
    max_capacity = 10
    min_capacity = 3
  }

  gateway_ip_configuration {
    name      = "${var.name_prefix}-agw-${var.descriptor}-configuration"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "Public-frontend-ip-configuration"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name  = backend_address_pool.value.name
      fqdns = [backend_address_pool.value.fqdn]
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.secret_id
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = var.trusted_client_certificates

    content {
      name = trusted_client_certificate.value.name
      data = trusted_client_certificate.value.data
    }
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profiles

    content {
      name                             = ssl_profile.value.name
      trusted_client_certificate_names = try(ssl_profile.value.trusted_client_certificate_names, null)
      verify_client_cert_issuer_dn     = try(ssl_profile.value.verify_client_cert_issuer_dn, null)

      dynamic "ssl_policy" {
        for_each = try(var.ssl_policy, null) == null ? [] : [1]
        content {
          cipher_suites        = try(var.ssl_policy.cipher_suites, null)
          min_protocol_version = try(var.ssl_policy.min_protocol_version, null)
          policy_type          = try(var.ssl_policy.policy_type, null)
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = "${http_listener.value.frontend_ip_configuration}-frontend-ip-configuration"
      frontend_port_name             = http_listener.value.portname
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      ssl_profile_name               = lookup(http_listener.value, "ssl_profile_name", null)
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content {
      host                                      = lookup(probe.value, "host", "127.0.0.1")
      interval                                  = lookup(probe.value, "interval", 30)
      name                                      = probe.value.name
      protocol                                  = lookup(probe.value, "protocol", "Https")
      path                                      = lookup(probe.value, "path", "/")
      timeout                                   = lookup(probe.value, "timeout", 20)
      unhealthy_threshold                       = lookup(probe.value, "unhealthy_threshold", 3)
      port                                      = lookup(probe.value, "port", null)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", null)
      dynamic "match" {
        for_each = lookup(probe.value, "use_custom_match", false) ? [1] : []
        content {
          body = ""
          status_code = [
            "200",
            "201",
            "401",
            "403",
            "404",
            "302"
          ]
        }
      }
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      name                                = backend_http_settings.value.name
      path                                = lookup(backend_http_settings.value, "path", null)
      port                                = lookup(backend_http_settings.value, "port", 443)
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      protocol                            = lookup(backend_http_settings.value, "protocol", "Https")
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules

    content {
      name                       = request_routing_rule.value.name
      rule_type                  = "Basic"
      priority                   = request_routing_rule.value.priority
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      rewrite_rule_set_name      = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_sets

    content {
      name = rewrite_rule_set.value.name

      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rules

        content {
          name          = coalesce(rewrite_rule.value.name, "rewrite-rule-${rewrite_rule.key + 1}")
          rule_sequence = coalesce(rewrite_rule.value.rule_sequence, rewrite_rule.key + 1)

          dynamic "condition" {
            for_each = coalesce(rewrite_rule.value.conditions, [])

            content {
              variable    = condition.value.variable
              pattern     = condition.value.pattern
              ignore_case = condition.value.ignore_case
              negate      = condition.value.negate
            }
          }

          dynamic "request_header_configuration" {
            for_each = coalesce(rewrite_rule.value.request_header_configurations, [])

            content {
              header_name  = request_header_configuration.value.header_name
              header_value = request_header_configuration.value.header_value
            }
          }

          dynamic "response_header_configuration" {
            for_each = coalesce(rewrite_rule.value.response_header_configurations, [])

            content {
              header_name  = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
          }
        }
      }
    }
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

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics ? 1 : 0
  name                       = lower("agw-${var.name_prefix}-agw-${var.descriptor}-diags")
  target_resource_id         = azurerm_application_gateway.this.id
  log_analytics_workspace_id = var.log_analytics_resource_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_logs

    content {
      category = enabled_log.value.category

      retention_policy {
        enabled = enabled_log.value.retention_enabled
        days    = enabled_log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_metrics

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type, metric]
  }
}

resource "azapi_update_resource" "verify_client_revocation" {
  type        = "Microsoft.Network/applicationGateways@2022-09-01"
  resource_id = azurerm_application_gateway.this.id
  body = jsonencode({
    properties = {
      sslProfiles = [
        for profile in var.ssl_profiles : {
          properties = {
            clientAuthConfiguration = {
              verifyClientRevocation = lookup(profile, "verify_client_revocation", false) ? "OCSP" : "None"
            }
          }
        }
      ]
    }
  })
}
