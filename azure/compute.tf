resource "azurerm_network_interface" "nic" {
  name                      = "${var.machine}-Interface"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.homolog.name
  network_security_group_id = azurerm_network_security_group.default_group.id

  ip_configuration {
    name                          = "NICConfiguration"
    subnet_id                     = azurerm_subnet.InternalSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "OSvm" {
  name           = var.machine
  location       = var.location
  admin_username = var.AdminUser

  resource_group_name   = azurerm_resource_group.homolog.name
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "Standard_B1s"

  allow_extension_operations    = false
  delete_os_disk_on_termination = true

  admin_ssh_key {
    username   = var.AdminUser
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "OsDisk"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }


  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine_extension" "extension" {
  name                       = "hostname"
  virtual_machine_id         = azurerm_linux_virtual_machine.OSvm.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true
}
