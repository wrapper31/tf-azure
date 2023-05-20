variable "source_event_hub_namespace" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "Event hub namespace to connect to ADX"
}

variable "source_event_hubs" {
  type = list(object({
    consumer_group_name = string
    event_hub_name      = string
    event_hub_id        = string
  }))
  description = "List of source event hubs to create tables and mapping for"
}

variable "adx_cluster" {
  description = "ADX cluster to create the database in"
  type = object({
    name                = string
    resource_group_name = string
    identity_name       = string
  })
}

variable "adx_database_name" {
  description = "name of the ADX database to send data to"
  type        = string
}

variable "adx_target_table_name" {
  description = "name of the ADX table to send data to"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "descriptor" {
  description = "Descriptor for the resource"
  type        = string
}

variable "maximum_batching_timespan" {
  description = "Maximum batching timespan for data ingestion, format 00:mm:ss.  Minimum 10 seconds, Maximum 30 minutes"
  type        = string
  default     = "00:05:00"
}
