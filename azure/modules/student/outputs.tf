output "username" {
  value = azuread_user.user.user_principal_name
}

output "portal_url" {
  value = "https://portal.azure.com"
}
