resource "azurerm_service_plan" "webapp" {
  name                = "${var.webapp_prefix}-sp"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.webapp_prefix}-webapp"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.webapp.id
  site_config {
    application_stack {
      node_version = var.application_stack_version
    }
      
  }

  timeouts {
    create = "30m"
    update = "30m"
  }

  tags = var.tags
}
