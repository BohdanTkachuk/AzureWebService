provider "azurerm" {
  
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id

  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
  tags = {
    Name = "Udacity-project"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
   tags = {
    Name = "Udacity-project"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/24"]
   
}

resource "azurerm_network_interface" "main" {
  count               = var.instances 
  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags = {
    Name = "Udacity-project"
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-pub-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
  tags = {
    Name = "Udacity-project"
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Name = "Udacity-project"
  }
  security_rule {
    name                       = "InboundAllowedVnet"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "OutboundAllowedVnet"
    priority                   = 210
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "InboundDeny"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }

}

resource "azurerm_lb" "main" {
  name                = "${var.prefix}-lb"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Name = "Udacity-project"
  }

  frontend_ip_configuration  {
    name                 = azurerm_public_ip.main.name
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_availability_set" "main" {
  name                = "AvailabilitySet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  platform_fault_domain_count = 2
  tags = {
    Name = "Udacity-project"
  }
}


resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "tcpProbe"
  port                = 80
}

resource "azurerm_lb_rule" "main" {
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_public_ip.main.name
}

data "azurerm_resource_group" "image" {
  name = "imageResourceGroup"
}

data "azurerm_image" "image" {
  name                = "ubuntuImage"
  resource_group_name = data.azurerm_resource_group.image.name
}

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.instances
  name                            = "${var.prefix}-vm-${count.index}"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2_v2"
  admin_username                  = var.user
  admin_password                  = var.password

  disable_password_authentication = false
  tags = {
    Name = "Udacity-project"
  }
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  source_image_id = data.azurerm_image.image.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}

resource "azurerm_managed_disk" "main" {
  count = var.instances
  name                 = "${var.prefix}-disk-vm-${count.index}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}


