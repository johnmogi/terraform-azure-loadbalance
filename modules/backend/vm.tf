resource "azurerm_linux_virtual_machine" "backendServer" {

  name                = "sysadminMachine"
  location            = var.location
  resource_group_name = var.rg_name
  size                = "Standard_b2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false
  network_interface_ids = [ var.nic_ids ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }


  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
 resource "azurerm_virtual_machine_extension" "backendEndServerVm" {
   name                            = "backendMachine01"
   virtual_machine_id   = azurerm_linux_virtual_machine.backendServer.id
   publisher            = "Microsoft.Azure.Extensions"
   type                 = "CustomScript"
   type_handler_version = "2.0"

   settings = <<SETTINGS
     {
     "fileUris": [ "https://kodo.press/sela/backend.sh" ],
     "commandToExecute": "sh ./backend.sh"
     }
 SETTINGS
   tags = {
     environment = "Development"
   }
 }