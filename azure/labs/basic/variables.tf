variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string

}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string

}

variable "student_username" {
  description = "EntraID username"
  type        = string
}

variable "student_password" {
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
    student     = "true"
    lab         = "basic"
  }

}

locals {
  tags = merge(var.tags, { student_name = var.student_username })
}
