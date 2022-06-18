resource "azurerm_resource_group" "weight_app_fix" {
  name     = "weight_app_fix"
  location = "East Us"
    tags = {
    environment = "development"
    stage       = "load balance weight group"
  }
}
