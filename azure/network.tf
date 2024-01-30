resource "azurerm_virtual_network" "Internal" {
  name                = "InternalVNet"
  resource_group_name = azurerm_resource_group.homolog.name
  location            = var.location
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "InternalSubnet" {
  name                 = "InternalSubnet"
  resource_group_name  = azurerm_resource_group.homolog.name
  virtual_network_name = azurerm_virtual_network.Internal.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicSubnet"
  resource_group_name  = azurerm_resource_group.homolog.name
  virtual_network_name = azurerm_virtual_network.Internal.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "PublicIP" {
  name                = "PublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.homolog.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "this" {
  name                = "Internalnsg"
  location            = azurerm_resource_group.InternalVNet.location
  resource_group_name = azurerm_resource_group.InternalSubnet.name

  security_rule {
    name                       = "Block External"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Denied"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = ["22", "3389", "80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.InternalSubnet.id
  network_security_group_id = azurerm_network_security_group.Internalnsg.id
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.PublicSubnet.id
  network_security_group_id = azurerm_network_security_group.Publicnsg.id
}
