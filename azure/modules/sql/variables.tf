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

##################
# Database info  #
##################

variable "db_username" {
  type        = string
  description = "value of the Azure database username"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "value of the Azure database password"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "value of the Azure database name"
}



