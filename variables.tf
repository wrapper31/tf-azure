variable "resource_group_name" {
  description = "The Resouce group name to provision resources"
  type        = string
}

variable "name_prefix" {
  description = "The prefix name.i.e. a210298-s1-musea2"
  type        = string
}

variable "descriptor" {
  description = "The descriptor which will added at the end of the resource name"
  type        = string
}

variable "location" {
  description = "The location where resources need to be build"
  type        = string
}

variable "subnet_id" {
  description = "The subnet id which you want to refere for your resource provisioning"
  type        = string
}

variable "tags" {
  description = "The tag name (key=value)"
  type        = map(string)
  default     = {}
}

variable "private" {
  description = "Whether to make this cluster private or not"
  type        = bool
  default     = true
}

variable "node_type_system" {
  description = "Node SKU in the system node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "min_node_count_system" {
  description = "Minimum number of nodes in the system node pool"
  type        = number
  default     = 1
}

variable "max_node_count_system" {
  description = "Maximum number of nodes in the system node pool"
  type        = number
  default     = 3
}

variable "node_type_app" {
  description = "Node SKU in the app node pool"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "min_node_count_app" {
  description = "Minimum number of nodes in the app node pool"
  type        = number
  default     = 1
}

variable "max_node_count_app" {
  description = "Maximum number of nodes in the app node pool"
  type        = number
  default     = 5
}

variable "acr_id" {
  description = "Azure container registery id"
  type        = string
}

variable "resource_group_id" {
  description = "ID of the resource group to contain the resources"
  type        = string
}

variable "virtual_network_rg_id" {
  description = "Virtual Network resource group ID"
  type        = string
}

variable "enable_diagnostics" {
  description = "Whether or not to send logs and metrics to a Log Analytics Workspace"
  type        = bool
  default     = false
}

variable "log_analytics_resource_id" {
  description = "The resource ID of the Log Analytics Workspace to which logs and metrics will be sent; must not be null if enabled_diagnostics is true"
  type        = string
  default     = null
}

# azure kubernetes service resource logs https://learn.microsoft.com/en-us/azure/aks/monitor-aks#collect-resource-logs
variable "diagnostic_logs" {
  description = "category of logs to be collected see https://learn.microsoft.com/en-us/azure/aks/monitor-aks#collect-resource-logs"
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [
    {
      category          = "kube-apiserver"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "kube-audit"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "kube-audit-admin"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "kube-controller-manager"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "kube-scheduler"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "cluster-autoscaler"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "cloud-controller-manager"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "guard"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "csi-azuredisk-controller"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "csi-azurefile-controller"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "csi-snapshot-controller"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

# azure kubernetes service metrics https://learn.microsoft.com/en-us/azure/aks/monitor-aks-reference#metrics
variable "diagnostic_metrics" {
  description = "category of metrics to be collected see https://learn.microsoft.com/en-us/azure/aks/monitor-aks-reference#metrics"
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

variable "ingress_application_gateway" {
  description = "Specifies the Application Gateway Ingress Controller addon configuration."
  type = object({
    enabled    = bool
    gateway_id = string
  })
  default = {
    enabled    = false
    gateway_id = null
  }
}

variable "os_sku_windows" {
  description = "(Optional) Specifies the OS SKU used by the agent pool. Possible values include: Windows2019, Windows2022"
  type        = string
  default     = "Windows2019"
}

variable "network_plugin" {
  description = "(Required) Network plugin to use for networking. Currently supported values are azure, kubenet"
  type        = string
  default     = "kubenet"
}

variable "enable_windows_node_pool" {
  description = "(Optional) To create windows node pool set it to true. Default is false"
  type        = string
  default     = "false"
}

variable "csi_driver_enabled" {
  description = "Enable Azure CSI Driver for Kubernetes"
  type        = bool
  default     = true
}

variable "outbound_type" {
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster"
  type        = string
  default     = "userDefinedRouting"
}
