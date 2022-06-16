resource "azurerm_resource_group" "weight_app" {
  name     = "weight_app"
  location = "East Us"
    tags = {
    environment = "development"
    stage       = "load balance weight group"
  }
}

# # sysadmin machine for manual checks
# resource "azurerm_linux_virtual_machine" "sysadmin" {
#   name                = "sysadmin-machine"
#   resource_group_name = azurerm_resource_group.weight_app.name
#   location            = azurerm_resource_group.weight_app.location
#   size                = "Standard_b1s"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     azurerm_network_interface.network_interface_app.id
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts-gen2"
#     version   = "latest"
#   }
# }