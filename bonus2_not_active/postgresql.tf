resource "azurerm_private_dns_zone" "weight_app_fix" {
  name                = "weight_app_fix.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.weight_app_fix.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "weight_app_fix" {
  name                  = "weight_app_fixVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.weight_app_fix.name
  virtual_network_id    = azurerm_virtual_network.weight_app_fix_network.id
  resource_group_name   = azurerm_resource_group.weight_app_fix.name
}

resource "azurerm_postgresql_flexible_server" "weight_app_fix" {
  name                   = "weight-app-psqlflexibleserver"
  resource_group_name    = azurerm_resource_group.weight_app_fix.name
  location               = azurerm_resource_group.weight_app_fix.location
  version                = "12"
#   delegated_subnet_id    = azurerm_subnet.weight_app_fix.id
  private_dns_zone_id    = azurerm_private_dns_zone.weight_app_fix.id
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "GP_Standard_D4s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.weight_app_fix]

}