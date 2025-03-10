# Create EntraID User
resource "azuread_user" "user" {
  user_principal_name   = "${var.username}@cloudsteak.com"
  display_name          = upper(var.username)
  mail_nickname         = var.username
  password              = var.password
  force_password_change = false
  account_enabled       = true
}

# Assign Contributor Role
resource "azurerm_role_assignment" "contributor" {
  scope                = var.resource_group_id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.user.object_id
}

