terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "tfstatepy0pfx"
    container_name       = "labs"
    key                  = "labs.basic.terraform.tfstate-student"
  }
}
