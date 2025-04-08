# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.username}-basic-rg"
  location = var.location
}

module "STUDENT" {
  source              = "../../modules/student"
  location            = var.location
  username            = var.username
  password            = var.password
  resource_group_id   = azurerm_resource_group.rg.id
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}


# module "WEBAPP" {
#   source              = "../../modules/webapp"
#   location            = var.location
#   webapp_prefix       = var.username
#   resource_group_name = azurerm_resource_group.rg.name
#   os_type             = "Linux"
#   sku                 = "B1"
#   tags                = local.tags
# }
