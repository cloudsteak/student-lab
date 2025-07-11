################
# Basic Inputs #
################
variable "subscription_id" {
  type        = string
  description = "value of the Azure subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "value of the Azure resource group name"
}

variable "location" {
  type        = string
  description = "value of the Azure location"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    owner   = "Evolvia"
    purpose = "Practice"
  }
}

####################
# App Service Plan #
####################

variable "app_service_plan_sku" {
  type        = string
  description = "value of the Azure app service plan SKU"
  default     = "B2"
}


variable "app_service_plan_worker_count" {
  type        = number
  description = "value of the Azure app service plan capacity"
  default     = 1
}


variable "web_app_plan_os" {
  type        = string
  description = "value of the Azure app service plan OS"
  default     = "Linux"
}

