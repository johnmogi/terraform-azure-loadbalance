
resource "azurerm_virtual_network" "weight_app_fix_network" {
  name                = "weight_app_fix"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.weight_app_fix.location
  resource_group_name = azurerm_resource_group.weight_app_fix.name
}
## PUBLIC subnet:
resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontendSubnet"
  resource_group_name  = azurerm_resource_group.weight_app_fix.name
  virtual_network_name = azurerm_virtual_network.weight_app_fix_network.name
  address_prefixes     = ["10.0.10.0/24"]
}
## PRIVATE subnet:
resource "azurerm_subnet" "backend_subnet" {
  name                 = "privatenet"
  resource_group_name  = azurerm_resource_group.weight_app_fix.name
  virtual_network_name = azurerm_virtual_network.weight_app_fix_network.name
  address_prefixes     = ["10.0.0.0/24"]
}
