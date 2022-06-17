resource "azurerm_private_dns_zone" "weight_app" {
  name                = "weight_app.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.weight_app.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "weight_app" {
  name                  = "weight_appVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.weight_app.name
  virtual_network_id    = azurerm_virtual_network.weight_app_network.id
  resource_group_name   = azurerm_resource_group.weight_app.name
}

resource "azurerm_postgresql_flexible_server" "weight_app" {
  name                   = "weight-app-psqlflexibleserver"
  resource_group_name    = azurerm_resource_group.weight_app.name
  location               = azurerm_resource_group.weight_app.location
  version                = "12"
#   delegated_subnet_id    = azurerm_subnet.weight_app.id
  private_dns_zone_id    = azurerm_private_dns_zone.weight_app.id
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "GP_Standard_D4s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.weight_app]

}