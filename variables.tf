variable "resource_group_name" {
  type        = string
  description = "Resource group where the cluster has been provisioned."
}

variable "region" {
  type        = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}

variable "tags" {
  type        = list(string)
  description = "Tags that should be applied to the service"
  default     = []
}

variable "name_prefix" {
  type        = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default     = ""
}

variable "plan" {
  type        = string
  description = "The type of plan the service instance should run under (tiered-pricing)"
  default     = "tiered-pricing"
}

variable "provision" {
  type        = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default     = true
}

variable "name" {
  type        = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default     = ""
}

variable "private_endpoint" {
  type        = string
  description = "Flag indicating that the service should be created with private endpoints"
  default     = "true"
}

variable "label" {
  type        = string
  description = "The label used as generate the name of the resource using the name_prefix"
  default     = "keyprotect"
}

variable "skip" {
  type        = bool
  description = "Flag indicating that the logic should be skipped (i.e. don't do anything)"
  default     = false
}
