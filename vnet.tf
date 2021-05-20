resource "azurerm_virtual_network" "sandbox1" {
  name                      = "sandbox1-vnet1"
  address_space             = ["10.1.0.0/16"]
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name
}


resource "azurerm_subnet" "sandbox1subnet1" {
  name                      = "sandbox1subnet1"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox1.name
  address_prefixes          = ["10.1.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "sandbox1nsgass" {
  subnet_id                 = azurerm_subnet.sandbox1subnet1.id
  network_security_group_id = azurerm_network_security_group.sandbox1nsg.id
}

resource "azurerm_route_table" "sandbox1subnet1rt" {
  name                = "sandbox1subnet1-routetable"
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name

  route {
    name                   = "SPOKETEST"
    address_prefix         = "10.3.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.200.1.10"
  }
}

resource "azurerm_subnet_route_table_association" "sandbox1subnet1rtass" {
  subnet_id                 = azurerm_subnet.sandbox1subnet1.id
  route_table_id            = azurerm_route_table.sandbox1subnet1rt.id
}

#


resource "azurerm_virtual_network" "sandbox2" {
  name                      = "sandbox2-vnet2"
  address_space             = ["10.200.0.0/16"]
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name
}

#!#

resource "azurerm_subnet" "sandbox2subnet1" {
  name                      = "sandbox2subnet1"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox2.name
  address_prefixes          = ["10.200.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "sandbox2nsgass" {
  subnet_id                 = azurerm_subnet.sandbox2subnet1.id
  network_security_group_id = azurerm_network_security_group.sandbox2nsg.id
}

resource "azurerm_route_table" "sandbox2subnet1rt" {
  name                = "sandbox2subnet1-routetable"
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name

  route {
    name                   = "OnPrem"
    address_prefix         = "100.100.100.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.1.10"
  }
}

resource "azurerm_subnet_route_table_association" "sandbox2subnet1rtass" {
  subnet_id                 = azurerm_subnet.sandbox2subnet1.id
  route_table_id            = azurerm_route_table.sandbox2subnet1rt.id
}

#!#


resource "azurerm_virtual_network" "sandbox3" {
  name                      = "sandbox3-vnet3"
  address_space             = ["10.3.0.0/16"]
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name
}


resource "azurerm_subnet" "sandbox3subnet1" {
  name                      = "sandbox3subnet1"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox3.name
  address_prefixes          = ["10.3.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "sandbox3nsgass" {
  subnet_id                 = azurerm_subnet.sandbox3subnet1.id
  network_security_group_id = azurerm_network_security_group.sandbox3nsg.id
}

resource "azurerm_route_table" "sandbox3subnet1rt" {
  name                = "sandbox3subnet1-routetable"
  location                  = azurerm_resource_group.transithub.location
  resource_group_name       = azurerm_resource_group.transithub.name

  route {
    name                   = "DGW"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.200.1.10"
  }
}

resource "azurerm_subnet_route_table_association" "sandbox3subnet1rtass" {
  subnet_id                 = azurerm_subnet.sandbox3subnet1.id
  route_table_id            = azurerm_route_table.sandbox3subnet1rt.id
}

################
#VNet Peering
################

resource "azurerm_virtual_network_peering" "vnet1to2" {
  name                      = "vnet1to2"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox1.name
  remote_virtual_network_id = azurerm_virtual_network.sandbox2.id
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "vnet2to1" {
  name                      = "vnet2to1"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox2.name
  remote_virtual_network_id = azurerm_virtual_network.sandbox1.id
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "vnet3to2" {
  name                      = "vnet3to2"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox3.name
  remote_virtual_network_id = azurerm_virtual_network.sandbox2.id
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "vnet2to3" {
  name                      = "vnet2to3"
  resource_group_name       = azurerm_resource_group.transithub.name
  virtual_network_name      = azurerm_virtual_network.sandbox2.name
  remote_virtual_network_id = azurerm_virtual_network.sandbox3.id
  allow_forwarded_traffic = true
}