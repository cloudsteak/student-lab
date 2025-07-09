# Random name for Storageaccount
resource "random_string" "sa_name" {
  length  = 18
  upper   = false
  special = false
}

resource "azurerm_storage_account" "primary" {
  name                     = "sa${random_string.sa_name.result}" # Ensure the name is globally unique
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.tier
  account_replication_type = var.replication_type
  sftp_enabled             = var.sftp_enabled
  nfsv3_enabled            = var.nfsv3_enabled

  tags = var.tags
}
