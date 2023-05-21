variable "asms" {
  type        = string
  description = "ASMS Number"
}

variable "env" {
  type        = string
  description = "Name of the deployment environment"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "resource_prefix_no_dash" {
  type        = string
  description = "Prefix for all resource names with no dashes (-)"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "resource_group_id" {
  type        = string
  description = "ID of the resource group"
}

variable "service_plan_id" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "key_vault_identity_id" {
  type = string
}

##AKS ACR
##Node type information
variable "node_count" {
  type        = string
  description = "The number of K8S nodes to provision."
  default     = 1
}
variable "max_count" {
  type        = string
  description = "Max number of K8S nodes to provision."
  default     = 4
}
variable "min_count" {
  type        = string
  description = "Min number of K8S nodes to provision."
  default     = 1
}

variable "node_type" {
  type        = string
  description = "The size of each node."
  default     = "Standard_DS2_v2"
}

variable "dns_prefix" {
  type        = string
  description = "DNS Prefix"
  default     = "tfq"
}

variable "iot_hub_subnet_id" {
  type        = string
  description = "Subnet ID for IoT Hub"
}

variable "event_hub_subnet_id" {
  type        = string
  description = "Subnet ID for Event Hub"
}

# variable "event_grid_subnet_id" {
#   type        = string
#   description = "Subnet ID for Event Grid"
# }

variable "function_apps_subnet_id" {
  type        = string
  description = "Subnet ID for Functions"
}

variable "service_bus_subnet_id" {
  type        = string
  description = "Subnet ID for Service Bus"
}

variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for AKS"
}

# variable "dev_portal_subnet_id" {
#   type        = string
#   description = "Subnet ID for Dev Portal"
# }

# variable "storage_account_subnet_id" {
#   type        = string
#   description = "Subnet ID for Storage Account"
# }

variable "key_vault_subnet_id" {
  type        = string
  description = "Subnet ID for Key Vault"
}

variable "app_service_subnet_id" {
  type        = string
  description = "Subnet ID for App Service"
}

variable "cosmos_db_subnet_id" {
  type        = string
  description = "Subnet ID for Cosmos DB"
}

variable "app_gateway_subnet_id" {
  type        = string
  description = "Subnet ID for App Gateway"
}
variable "description" {
  type        = string
  description = "description of the alert"
}

# variable "ssh_key" {
#   type= string
#   description = "SSH Key"
# }
####################

# variable "name" {
#   type        = string
#   description = "Name of helm release"
#   default     = "ingress-nginx"
# }
# variable "namespace" {
#   type        = string
#   description = "Name of namespace where nginx controller should be deployed"
#   default     = "ingress-nginx"
# }

# variable "chart_version" {
#   type        = string
#   description = "HELM Chart Version for nginx controller"
#   default     = "4.1.4"
# }

# variable "atomic" {
#   type        = bool
#   description = "If set, installation process purges chart on fail"
#   default     = false
# }

# variable "ingress_class_name" {
#   type        = string
#   description = "IngressClass resource name"
#   default     = "nginx"
# }

# variable "ingress_class_is_default" {
#   type        = bool
#   description = "IngressClass resource default for cluster"
#   default     = true
# }

# variable "ip_address" {
#   type        = string
#   description = "External Static Address for loadbalancer (Doesn't work with AWS)"
#   default     = null
# }

# variable "controller_kind" {
#   type        = string
#   description = "Controller type: DaemonSet, Deployment etc.."
#   default     = "DaemonSet"
# }
# variable "controller_daemonset_useHostPort" {
#   type        = bool
#   description = "Also use host ports(80,443) for pods. Node Ports in services will be untouched"
#   default     = false
# }
# variable "controller_service_externalTrafficPolicy" {
#   type        = string
#   description = "Traffic policy for controller. See docs."
#   default     = "Local"
# }
# variable "controller_request_memory" {
#   type        = number
#   description = "Memory request for pod. Value in MB"
#   default     = 140
# }

# variable "publish_service" {
#   type        = bool
#   description = "Publish LoadBalancer endpoint to Service"
#   default     = true
# }

# variable "define_nodePorts" {
#   type        = bool
#   description = "By default service using NodePorts. It can be generated automatically, or you can assign this ports number"
#   default     = true
# }
# variable "service_nodePort_http" {
#   type        = string
#   description = "NodePort number for http"
#   default     = "32001"
# }
# variable "service_nodePort_https" {
#   type        = string
#   description = "NodePort number for https"
#   default     = "32002"
# }

# variable "metrics_enabled" {
#   type        = bool
#   description = "Allow exposing metrics for prometheus-operator"
#   default     = false
# }
# variable "disable_heavyweight_metrics" {
#   type        = bool
#   description = "Disable some 'heavyweight' or unnecessary metrics"
#   default     = false
# }

# variable "create_namespace" {
#   type        = bool
#   description = "Create a namespace"
#   default     = true
# }

# variable "additional_set" {
#   description = "Add additional set for helm"
#   default     = []
# }
# variable "aks_service_principal_object_id" {
#   type    = string
#   default = "cbabe400-fc1d-4a86-a03c-058c1028ec90"
# }
