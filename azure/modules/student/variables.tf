variable "location" {
  description = "Azure region"
  type        = string
  default     = "Poland Central"

}

variable "username" {
  description = "EntraID username"
  type        = string
}

variable "password" {
  description = "Password for the EntraID user"
  type        = string
  sensitive   = true
}

variable "module" {
  description = "Module name to construct resource group name"
  type        = string
}

variable "tags" {
  description = "Tags to be assigned to the resources"
  type        = map(string)
  default     = {
    environment = "training"
    owner       = "cloudmentor"
  }
  
}

variable "resource_group_id" {
  description = "Resource Group ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}
