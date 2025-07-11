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

##########################
# Storage Account Inputs #
##########################

variable "tier" {
  type        = string
  description = "value of the Azure storage account tier"
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "value of the Azure storage account replication type"
  default     = "LRS"
}

variable "sftp_enabled" {
  type    = bool
  default = "false"
}

variable "nfsv3_enabled" {
  type    = bool
  default = false
}
