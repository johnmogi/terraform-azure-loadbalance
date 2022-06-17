
resource "azurerm_lb" "azurerm_lb" {
  name                = "loadbalance1"
  location            = azurerm_resource_group.weight_app.location
  resource_group_name = azurerm_resource_group.weight_app.name

  # retrieve front end ip from machine
  frontend_ip_configuration {
    name                 = "frontend_ip"
    public_ip_address_id = azurerm_public_ip.frontend_public_ip.id
  }

}


# Load balancer rules

resource "azurerm_lb_rule" "azurerm_lb_rule" {
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  name                           = "lb-rule-http"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.azurerm_lb.frontend_ip_configuration[0].name

  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.azurerm_lb.id
  name            = "BackEndAddressPool"
}

module "vm_back"{
  source = "./modules/backend"
  location            = azurerm_resource_group.weight_app.location
  rg_name = azurerm_resource_group.weight_app.name
  admin_username = var.admin_username
  admin_password = var.admin_password
  nic_ids = azurerm_network_interface.network_interface_db[0].id

  }

  module "vm_front"{
  source = "./modules/frontend"
  count="3"
  location            = azurerm_resource_group.weight_app.location
  rg_name = azurerm_resource_group.weight_app.name
  admin_username = var.admin_username
  admin_password = var.admin_password
  vm_back = module.vm_back
  vm_front = "frontendMachine${count.index}"

  nic_fe_ids = [element(azurerm_network_interface.network_interface_app.*.id, count.index)]
  }

resource "azurerm_network_interface" "network_interface_app" {
  count               = "3"
  name                = "NC${count.index}"
  location            = azurerm_resource_group.weight_app.location
  resource_group_name = azurerm_resource_group.weight_app.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "network_interface_db" {
  count               = "1"
  name                = "postgres_network_interface"
  location            = azurerm_resource_group.weight_app.location
  resource_group_name = azurerm_resource_group.weight_app.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.backend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

