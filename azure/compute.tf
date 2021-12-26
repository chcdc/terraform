
resource "azurerm_network_interface" "nic" {
  name                          = "${var.machine}-Interface"
  location                      = "${var.location}"
  resource_group_name           = "${azurerm_resource_group.homolog.name}"
  network_security_group_id     = "${azurerm_network_security_group.default_group.id}"
  
  ip_configuration {
    name                                = "NICConfiguration"
    subnet_id                           = "${azurerm_subnet.InternalSubnet.id}"
    private_ip_address_allocation       = "Dynamic"
    public_ip_address_id                = "${azurerm_public_ip.PublicIP.id}"
  }
}

resource "azurerm_virtual_machine" "OSvm" {
    name                                = "${var.machine}"
    location                            = "${var.location}"
    resource_group_name                 = "${azurerm_resource_group.homolog.name}"
    network_interface_ids               = ["${azurerm_network_interface.nic.id}"]
    delete_os_disk_on_termination       = true 
    vm_size                             = "Standard_B1s" #"Standard_DS1_v2"

    storage_os_disk {
        name              = "OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "19.04"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.machine}"
        admin_username = "${var.AdminUser}"
        admin_password = "${var.AdminPass}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}
