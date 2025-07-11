################
# Basic Inputs #
################
variable "subscription_id" {
  type        = string
  description = "value of the Azure subscription ID"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "tags" {
  description = "Tags to be assigned to the resources"
  type        = map(string)
  default = {
    owner   = "Evolvia"
    purpose = "Practice"
  }
}

variable "app_service_plan_id" {
  type = string
}

variable "application_stack_version" {
  description = "The application stack for the webapp"
  type        = string
  default     = "22-lts" # Node.js 22 LTS
}
