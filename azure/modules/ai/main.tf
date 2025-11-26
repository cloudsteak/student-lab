# Random name for AI stuff
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}


locals {
  deployment_data = jsondecode(file("../../files/openai_deployments.json"))
}

# Create a new Azure OpenAI resource
module "openai" {
  source  = "Azure/openai/azurerm"
  version = "0.1.5"
  # insert the 2 required variables here
  account_name                  = "openai-${random_string.this.result}"
  custom_subdomain_name         = "${var.resource_group_name}-${random_string.this.result}"
  public_network_access_enabled = true
  location                      = var.location
  resource_group_name           = var.resource_group_name
  deployment                    = local.deployment_data
  tags                          = var.tags
  depends_on                    = [var.resource_group_name]

}

# Create a new Azure OpenAI resource
resource "azurerm_search_service" "this" {
  name                = "search-${random_string.this.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "basic"

  local_authentication_enabled = true
  authentication_failure_mode  = "http403"
}


resource "azurerm_storage_container" "this" {
  count                 = var.is_rag_files ? 1 : 0
  name                  = var.doc_container_name
  # storage_account_id    = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.rag_storage_account_name}"
  storage_account_name = var.rag_storage_account_name
  container_access_type = var.doc_container_access_type
  depends_on            = [var.rag_storage_account_name]
}



resource "azurerm_storage_blob" "this" {
  for_each               = var.is_rag_files ? fileset(var.local_doc_directory_path, "*.*") : [] # Match md files in the directory
  name                   = each.value                                   # Blob name (same as the file name)
  storage_account_name   = var.rag_storage_account_name
  storage_container_name = azurerm_storage_container.this[0].name
  type                   = "Block"
  source                 = "${var.local_doc_directory_path}/${each.value}" # Full path to the local file
  depends_on             = [azurerm_storage_container.this]
}



