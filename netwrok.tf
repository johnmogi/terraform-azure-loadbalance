
resource "azurerm_virtual_network" "weight_app_network" {
  name                = "weight_app"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.weight_app.location
  resource_group_name = azurerm_resource_group.weight_app.name
}
## PUBLIC subnet:
resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontendSubnet"
  resource_group_name  = azurerm_resource_group.weight_app.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name
  address_prefixes     = ["10.0.10.0/24"]
}
## PRIVATE subnet:
resource "azurerm_subnet" "backend_subnet" {
  name                 = "privatenet"
  resource_group_name  = azurerm_resource_group.weight_app.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name
  address_prefixes     = ["10.0.0.0/24"]
}
