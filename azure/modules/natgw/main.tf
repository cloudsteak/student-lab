# Random name for NATGW
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}


# Public IP for NAT Gateway
resource "azurerm_public_ip" "this" {
  name                = "natgw-pip-${random_string.this.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.nat_gateway_pip_allocation_method
  sku                 = var.nat_gateway_pip_sku
  tags                = var.tags

  depends_on = [var.vnet_name, var.vnet_subnet_id, var.resource_group_name]
}

# NAT Gateway
resource "azurerm_nat_gateway" "this" {
  name                    = "natgw-${random_string.this.result}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags                    = var.tags
}

# NAT Gateway Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

# Associate NAT Gateway with Subnet
resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = var.vnet_subnet_id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

