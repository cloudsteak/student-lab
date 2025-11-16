variable "location" {
  description = "Azure region"
  type        = string
  default     = "Sweden Central"

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

variable "tags" {
  description = "Tags to be assigned to the resources"
  type        = map(string)
  default = {
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

variable "group_name" {
  type        = string
  description = "User Group Name for Lab Users"
  default     = "Evolvia-Labs"
}
