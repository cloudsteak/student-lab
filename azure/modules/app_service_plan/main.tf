# Random name for App Service Plan
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}

# App Service Plan
resource "azurerm_service_plan" "this" {
  name                = "app-plan-${random_string.this.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  worker_count        = var.app_service_plan_worker_count

  os_type  = var.web_app_plan_os
  sku_name = var.app_service_plan_sku
}
