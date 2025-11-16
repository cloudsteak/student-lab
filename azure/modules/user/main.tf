# Create EntraID User
resource "azuread_user" "user" {
  user_principal_name   = "${var.username}@evolvia.hu"
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

# Add user to Group
resource "azuread_group_member" "user_in_group" {
  group_object_id  = data.azuread_group.user_group.object_id
  member_object_id = azuread_user.user.id
}
