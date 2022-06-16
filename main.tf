resource "azurerm_resource_group" "weight_app" {
  name     = "weight_app"
  location = "East Us"
    tags = {
    environment = "development"
    stage       = "load balance weight group"
  }
}
