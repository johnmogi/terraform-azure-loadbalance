
# PUBLIC IP
resource "azurerm_public_ip" "frontend_public_ip" {
  name                = "weight_app_fix_public_ip"
  location            = azurerm_resource_group.weight_app_fix.location
  resource_group_name = azurerm_resource_group.weight_app_fix.name
  allocation_method   = "Static"
  idle_timeout_in_minutes = 30
}
