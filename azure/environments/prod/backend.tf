terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-backend-rg"
    storage_account_name  = "tfstate530d71ad"
    container_name        = "tfstate-student"
    key                   = "prod.terraform.tfstate-student"
  }
}
