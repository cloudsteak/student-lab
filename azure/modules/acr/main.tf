# File: azure/modules/acr/main.tf

# Random name for ACR
resource "random_string" "acr_name" {
  length  = 12
  upper   = false
  special = false
}

# Create Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "acr${random_string.acr_name.result}" # Ensure the name is globally unique
  admin_enabled       = true
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  tags                = var.tags
}
