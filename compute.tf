###

resource "azurerm_network_interface" "vn01nic01" {
name                = "vm-11-nic"
location            = azurerm_resource_group.transithub.location
resource_group_name = "transithub"
enable_ip_forwarding = true

    ip_configuration {
    name                          = "ip-vm-11"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.1.10"
#    public_ip_address_id          = azurerm_public_ip.pip11.id
    subnet_id                     = azurerm_subnet.sandbox1subnet1.id
    }
}


resource "azurerm_linux_virtual_machine" "deb01" {
  name                = "deb01-machine"
  resource_group_name = azurerm_resource_group.transithub.name
  location            = azurerm_resource_group.transithub.location
  size                = "Standard_B1s"
  admin_username      = "##############"
  network_interface_ids = [
    azurerm_network_interface.vn01nic01.id,
  ]

  admin_ssh_key {
    username   = "##############"
    public_key = file("##############")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}


#############

resource "azurerm_public_ip" "pip2" {
  name                    = "pip2"
  location                = azurerm_resource_group.transithub.location
  resource_group_name     = azurerm_resource_group.transithub.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "vn02nic1" {
name                = "vm-2-nic1"
location            = azurerm_resource_group.transithub.location
resource_group_name = "transithub"
enable_ip_forwarding = true

    ip_configuration {
    name                          = "ip-vm-2-1"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.200.1.10"
    public_ip_address_id          = azurerm_public_ip.pip2.id
    subnet_id                     = azurerm_subnet.sandbox2subnet1.id
    }
}

resource "azurerm_linux_virtual_machine" "debhub" {
  name                = "debhub-machine"
  resource_group_name = azurerm_resource_group.transithub.name
  location            = azurerm_resource_group.transithub.location
  size                = "Standard_B1s"
  admin_username      = "#########"
  network_interface_ids = [
    azurerm_network_interface.vn02nic1.id,
  ]

  admin_ssh_key {
    username   = "#########"
    public_key = file("##########")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}


resource "azurerm_network_interface" "vn03nic01" {
name                = "vm-31-nic"
location            = azurerm_resource_group.transithub.location
resource_group_name = "transithub"

    ip_configuration {
    name                          = "ip-vm-31"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.3.1.10"
    subnet_id                     = azurerm_subnet.sandbox3subnet1.id
    }
}


resource "azurerm_linux_virtual_machine" "deb03" {
  name                = "deb03-machine"
  resource_group_name = azurerm_resource_group.transithub.name
  location            = azurerm_resource_group.transithub.location
  size                = "Standard_B1s"
  admin_username      = "##############"
  network_interface_ids = [
    azurerm_network_interface.vn03nic01.id,
  ]

  admin_ssh_key {
    username   = "##############"
    public_key = file("##############")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}
