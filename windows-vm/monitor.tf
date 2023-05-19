resource "azurerm_virtual_machine_extension" "monitor_agent" {
  count = var.log_analytics_enabled ? 1 : 0

  name                       = "${var.name_prefix}-AzureMonitorWindowsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.this.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.12"
  automatic_upgrade_enabled  = true
  auto_upgrade_minor_version = true

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["GM ASMS No"],
      tags["GM Business Criticality"],
      tags["GM Strictest Data Classification"]
    ]
  }
}

resource "azurerm_monitor_data_collection_rule" "this" {
  count = var.log_analytics_enabled ? 1 : 0

  name                = "${var.name_prefix}-dcr-vm-${var.descriptor}"
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_resource_id
      name                  = "default-workspace"
    }
    azure_monitor_metrics {
      name = "default-azure-monitor-metrics"
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["default-azure-monitor-metrics"]
  }

  data_flow {
    streams      = ["Microsoft-Perf", "Microsoft-Event", "Microsoft-Syslog"]
    destinations = ["default-workspace"]
  }

  data_sources {
    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor Information(_Total)\\% Processor Time",
        "\\Processor Information(_Total)\\% Privileged Time",
        "\\Processor Information(_Total)\\% User Time",
        "\\Processor Information(_Total)\\Processor Frequency",
        "\\System\\Processes",
        "\\Process(_Total)\\Thread Count",
        "\\Process(_Total)\\Handle Count",
        "\\System\\System Up Time",
        "\\System\\Context Switches/sec",
        "\\System\\Processor Queue Length",
        "\\Memory\\% Committed Bytes In Use",
        "\\Memory\\Available Bytes",
        "\\Memory\\Committed Bytes",
        "\\Memory\\Cache Bytes",
        "\\Memory\\Pool Paged Bytes",
        "\\Memory\\Pool Nonpaged Bytes",
        "\\Memory\\Pages/sec",
        "\\Memory\\Page Faults/sec",
        "\\Process(_Total)\\Working Set",
        "\\Process(_Total)\\Working Set - Private",
        "\\LogicalDisk(_Total)\\% Disk Time",
        "\\LogicalDisk(_Total)\\% Disk Read Time",
        "\\LogicalDisk(_Total)\\% Disk Write Time",
        "\\LogicalDisk(_Total)\\% Idle Time",
        "\\LogicalDisk(_Total)\\Disk Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Read Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Write Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Transfers/sec",
        "\\LogicalDisk(_Total)\\Disk Reads/sec",
        "\\LogicalDisk(_Total)\\Disk Writes/sec",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Transfer",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Read",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Write",
        "\\LogicalDisk(_Total)\\Avg. Disk Queue Length",
        "\\LogicalDisk(_Total)\\Avg. Disk Read Queue Length",
        "\\LogicalDisk(_Total)\\Avg. Disk Write Queue Length",
        "\\LogicalDisk(_Total)\\% Free Space",
        "\\LogicalDisk(_Total)\\Free Megabytes",
        "\\Network Interface(*)\\Bytes Total/sec",
        "\\Network Interface(*)\\Bytes Sent/sec",
        "\\Network Interface(*)\\Bytes Received/sec",
        "\\Network Interface(*)\\Packets/sec",
        "\\Network Interface(*)\\Packets Sent/sec",
        "\\Network Interface(*)\\Packets Received/sec",
        "\\Network Interface(*)\\Packets Outbound Errors",
        "\\Network Interface(*)\\Packets Received Errors",
      ]
      name = "default-datasource-perfcounter"
    }

    windows_event_log {
      streams = ["Microsoft-WindowsEvent"]
      x_path_queries = [
        "Application!*[System[(Level=1 or Level=2)]]",
        "System!*[System[(Level=1 or Level=2)]]"
      ]
      name = "default-datasource-wineventlog"
    }

    syslog {
      facility_names = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "local0", "local1", "local2", "local3", "local4",
      "local5", "local6", "local7", "lpr", "mail", "news", "syslog", "user", "uucp"]
      log_levels = ["Error", "Critical", "Alert", "Emergency"]
      name       = "default-datasource-syslog"
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

resource "azurerm_monitor_data_collection_rule_association" "dcr" {
  count = var.log_analytics_enabled ? 1 : 0

  name                    = "${var.name_prefix}-dcra-vm-${var.descriptor}"
  target_resource_id      = azurerm_windows_virtual_machine.this.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.this[0].id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.log_analytics_enabled ? 1 : 0

  name                       = lower(format("%s-%s", azurerm_windows_virtual_machine.this.name, "diag"))
  target_resource_id         = azurerm_windows_virtual_machine.this.id
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
}
