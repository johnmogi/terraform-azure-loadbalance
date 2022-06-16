
# PUBLIC IP
resource "azurerm_public_ip" "frontend_public_ip" {
  name                = "weight_app_public_ip"
  location            = azurerm_resource_group.weight_app.location
  resource_group_name = azurerm_resource_group.weight_app.name
  allocation_method   = "Static"
}