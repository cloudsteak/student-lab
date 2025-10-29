# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.student_username
  location = var.location
  tags     = local.tags
  timeouts {
    create = "60m"
    delete = "60m"
  }
}

module "USER" {
  source              = "../../modules/user"
  location            = var.location
  username            = var.student_username
  password            = var.student_password
  resource_group_id   = azurerm_resource_group.rg.id
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

module "VNET" {
  source = "../../modules/vnet"

  location              = var.location
  subscription_id       = var.subscription_id
  resource_group_name   = azurerm_resource_group.rg.name
  vnet_address_space    = ["10.10.0.0/16"]
  subnet_address_prefix = "10.10.0.0/24"
  tags                  = var.tags

  depends_on = [module.USER]

}
