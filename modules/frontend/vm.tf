# application virtual machine
resource "azurerm_linux_virtual_machine" "frontendServer" {

  name                            = var.vm_front
  location            = var.location
  resource_group_name = var.rg_name
  disable_password_authentication = false
  #  size                = "Standard_F2"
  depends_on = [var.vm_back]
  size                  = "Standard_b2s"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.avset.id
  network_interface_ids =  var.nic_fe_ids 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  tags = {
    environment = "staging"
  }

}
# resource "azurerm_virtual_machine_extension" "frontendServerVm" {

#   name                            = "frontendMachine"
#   virtual_machine_id   = azurerm_linux_virtual_machine.frontendServer.id
#   publisher            = "Microsoft.Azure.Extensions"
#   type                 = "CustomScript"
#   type_handler_version = "2.0"

# #   settings = <<SETTINGS
# #     {
# #     "fileUris": [ "./frontend.sh" ],
# #     "commandToExecute": "sh ./frontend.sh"
# #     }
# # SETTINGS


#   tags = {
#     environment = "Production"
#   }
# }
resource "azurerm_availability_set" "avset" {
  name                         = "availabilitySet"
  location            = var.location
  resource_group_name = var.rg_name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3
  managed                      = true
}
