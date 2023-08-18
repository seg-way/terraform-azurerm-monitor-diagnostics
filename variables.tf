variable "name" {
  description = "Name of Diagnostic settings."
}

variable "target_ids" {
  description = "List of resource ids to create diagnostic settings for."
  type        = list(string)
}

variable "resource_group_name" {
  type = string
  description = "Resource Group Name for Event Hub Namespace"
}
variable "eventhub_namespace_name" {
  type = string
  description = "Event Hub Namspace Name"
}

variable "eventhub_name" {
  description = "Event Hub name"
}

variable "logs" {
  description = "List of log categories to log."
  type        = list(string)
  default     = []
}

variable "metrics" {
  description = "List of metric categories to track."
  type        = list(string)
  default     = []
}