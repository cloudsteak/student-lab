variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "webapp_prefix" {
  description = "The prefix for the webapp name"
  type        = string
  
}

variable "os_type" {
  description = "The OS type of the App Service Plan"
  type        = string
  default     = "Linux"
  
}

variable "sku" {
  description = "The SKU of the App Service Plan"
  type        = string
  
}

variable "tags" {
  description = "Tags to be assigned to the resources"
  type   =    map(string)
  default = {
    environment = "training"
    owner       = "cloudmentor"
  }
}

variable "application_stack_version" {
  description = "The application stack for the webapp"
    type        = string
    default     = "22-lts" # Node.js 22 LTS
}
