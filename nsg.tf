
 # PRIVATE Network Security Group and rule
resource "azurerm_network_security_group" "backend_subnet" {
  name                = "bENetworkSecurityGroup"
  location            = azurerm_resource_group.weight_app_fix.location
  resource_group_name = azurerm_resource_group.weight_app_fix.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Postgresql"
    priority                   = 901
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# PUBLIC Network Security Group and rule
resource "azurerm_network_security_group" "frontend_subnet" {
  name                = "FrontEndSecurityGroup"
  location            = azurerm_resource_group.weight_app_fix.location
  resource_group_name = azurerm_resource_group.weight_app_fix.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 901
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
  # connect be nic to nsg
resource "azurerm_network_interface_security_group_association" "be_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.network_interface_db[0].id
  network_security_group_id = azurerm_network_security_group.backend_subnet.id
}
    # connect fe nic to nsg
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.network_interface_app[0].id
  network_security_group_id = azurerm_network_security_group.frontend_subnet.id
}
    # connect fe nic to nsg
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc1" {
  network_interface_id      = azurerm_network_interface.network_interface_app[1].id
  network_security_group_id = azurerm_network_security_group.frontend_subnet.id
}
    # connect fe nic to nsg
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc2" {
  network_interface_id      = azurerm_network_interface.network_interface_app[2].id
  network_security_group_id = azurerm_network_security_group.frontend_subnet.id
}
