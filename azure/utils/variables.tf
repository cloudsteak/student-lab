variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "a471b6bb-b9ba-467d-a7c1-ef3c8cc1ee2b"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = "fcfac54b-22a2-4487-bef4-a762401fd6a0"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Poland Central"

}

variable "tags" {
  description = "Tags to be assigned to the resources"
  type        = map(string)
  default = {
    environment = "training"
    owner       = "cloudmentor"
    student     = "false"
  }

}

locals {
  tags = merge(var.tags)
}
