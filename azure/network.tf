resource "azurerm_virtual_network" "Internal"{
    name                    = "InternalVNet"
    resource_group_name     = "${azurerm_resource_group.homolog.name}"
    location                = "${var.location}"
    address_space           = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "InternalSubnet" {
    name = "InternalSubnet"
    resource_group_name         = "${azurerm_resource_group.homolog.name}"
    virtual_network_name        = "${azurerm_virtual_network.Internal.name}"
    address_prefix              = "10.0.2.0/24"
}

resource "azurerm_subnet" "PublicSubnet" {
    name = "PublicSubnet"
    resource_group_name         = "${azurerm_resource_group.homolog.name}"
    virtual_network_name        = "${azurerm_virtual_network.Internal.name}"
    address_prefix              = "10.0.3.0/24"
}

resource "azurerm_public_ip" "PublicIP" {
    name = "PublicIP"
    location = "eastus"
    resource_group_name     = "${azurerm_resource_group.homolog.name}"
    allocation_method       = "Dynamic"
}