data "azuread_group" "user_group" {
  display_name = var.group_name
}
