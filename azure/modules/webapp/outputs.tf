output "webapp_name" {
  value = azurerm_linux_web_app.this.name
}

output "webapp_url" {
  value = "https://${azurerm_linux_web_app.this.name}.azurewebsites.net"
}
