resource "azurerm_resource_group" "api_management" {
  name     = "utils-api-management-rg"
  location = var.location
}


resource "azurerm_api_management" "apim" {
  name                = "apim-lab-manager"
  location            = azurerm_resource_group.api_management.location
  resource_group_name = azurerm_resource_group.api_management.name
  publisher_name      = "Cloud Mentor"
  publisher_email     = "support@cloudmentor.hu"
  sku_name            = "Consumption_0" # Consumption tier

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_api_management_api" "health_api" {
  name                = "health-api"
  resource_group_name = azurerm_resource_group.api_management.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Health API"
  path                = "health"
  protocols           = ["https"]
}

resource "azurerm_api_management_api_operation" "get_operation" {
  operation_id        = "getHealth"
  api_name            = azurerm_api_management_api.health_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.api_management.name
  display_name        = "Get Health"
  method              = "GET"
  url_template        = "/health"
  response {
    status_code = 200
    description = "Service is healthy"
  }
}

