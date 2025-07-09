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
# VNET Inputs #
###############

variable "subnet_1_name" {
  type        = string
  description = "value of the Azure subnet 1 name"
  default     = "alapertelmezett"

}

variable "vnet_address_space" {
  type        = list(string)
  description = "value of the Azure virtual network address space"
}

variable "subnet_address_prefix" {
  type        = string
  description = "value of the Azure subnet address prefix"
}
