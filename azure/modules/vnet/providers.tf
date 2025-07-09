provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id
  tenant_id       = "fcfac54b-22a2-4487-bef4-a762401fd6a0"
}
