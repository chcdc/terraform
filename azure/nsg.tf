resource "azurerm_network_security_group" "default_group" {
    name        = "SecurityGroupDefault"
    resource_group_name = "${azurerm_resource_group.homolog.name}"
    location            = "${azurerm_resource_group.homolog.location}"
    tags                = "${azurerm_resource_group.homolog.tags}"
}

# Access Rules
resource "azurerm_network_security_rule" "AllowSSH" {
    name = "AllowSSH"
    resource_group_name         = "${azurerm_resource_group.homolog.name}"
    network_security_group_name = "${azurerm_network_security_group.default_group.name}"

    priority                    = 100
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 22
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}
resource "azurerm_network_security_rule" "AllowHTTP" {
    name = "AllowHTTP"
    resource_group_name         = "${azurerm_resource_group.homolog.name}"
    network_security_group_name = "${azurerm_network_security_group.default_group.name}"

    priority                    = 102
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 80
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_rule" "AllowHTTPS" {
    name = "AllowHTTPS"
    resource_group_name         = "${azurerm_resource_group.homolog.name}"
    network_security_group_name = "${azurerm_network_security_group.default_group.name}"

    priority                    = 103
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 443
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}