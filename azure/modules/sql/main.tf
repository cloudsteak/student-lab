# Random name for SQL
resource "random_string" "this" {
  length  = 10
  upper   = false
  special = false
}
resource "azurerm_mssql_server" "this" {
  name                         = "mssql-${random_string.this.result}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  tags                         = var.tags


}

resource "azurerm_mssql_database" "this" {
  name                        = var.db_name
  server_id                   = azurerm_mssql_server.this.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  max_size_gb                 = 5
  min_capacity                = 0.5
  read_replica_count          = 0
  read_scale                  = false
  sku_name                    = "GP_S_Gen5_1"
  zone_redundant              = false

  threat_detection_policy {
    disabled_alerts      = []
    email_account_admins = "Disabled"
    email_addresses      = []
    retention_days       = 0
    state                = "Disabled"
  }
  tags = var.tags

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "AllowPublicIP"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.1"
  end_ip_address   = "255.255.255.255"
}

