# Random name for WebApp
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapp-${random_string.this.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id
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

  depends_on = [ var.app_service_plan_id ]
}
