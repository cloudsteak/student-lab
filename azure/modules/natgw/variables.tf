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

###############
# NAT Gateway #
###############

variable "nat_gateway_pip_allocation_method" {
  type        = string
  description = "value of the Azure NAT gateway public IP allocation method"
  default     = "Static"
}

variable "nat_gateway_pip_sku" {
  type        = string
  description = "value of the Azure NAT gateway public IP SKU"
  default     = "Standard"

}

variable "vnet_name" {
  type = string
}

variable "vnet_subnet_id" {
  type        = string
  description = "value of the Azure virtual network subnet ID"
}

