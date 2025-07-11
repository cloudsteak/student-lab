# Random name for VNET
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${random_string.this.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = var.subnet_1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["${var.subnet_address_prefix}"]
}


resource "azurerm_network_security_group" "this" {
  name                = "nsg-vnet-${random_string.this.result}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {

    for_each = jsondecode(file("../../files/${var.nsg_file_name}"))
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

  tags = var.tags

  depends_on = [azurerm_subnet.this]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}
