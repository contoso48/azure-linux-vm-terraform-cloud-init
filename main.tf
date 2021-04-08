provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "Westeurope"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "test001"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size           = "Standard_DS1_v2"
  admin_username = "azureuser"
  admin_password = "CloudLab.1234!"
  allow_extension_operations = true
  disable_password_authentication = false
  # custom_data = "IyEvYmluL3NoDQpta2RpciAvdGVzdA0KY2QgL3Rlc3QNCmVjaG8gImhlbGxvLXRlc3QiID4+IC90ZXN0L3Rlc3QudHh0DQp0b3VjaCAiL3Rlc3QvdGVzdDIudHh0Ig0Kd2dldCAiaHR0cDovL3NsYXNoZG90Lm9yZyIgLU8gPj4gL3Rlc3QvaW5kZXguaHRtbA0KZWNobyAiZXhwb3J0IGh0dHBfcHJveHk9aHR0cHM6Ly8xMC42LjE1Ni4xMzI6ODA4MCIgPiAvZXRjL3Byb2ZpbGUuZC9wcm94eS5zaCAmJiBjaG1vZCA3NTUgL2V0Yy9wcm9maWxlLmQvcHJveHkuc2gNCmVjaG8gImV4cG9ydCBodHRwc19wcm94eT1odHRwczovLzEwLjYuMTU2LjEzMjo4MDgwIiA+PiAvZXRjL3Byb2ZpbGUuZC9wcm94eS5zaA0KZWNobyAiZXhwb3J0IG5vX3Byb3h5PWxvY2FsaG9zdCwxMjcuMC4wLjEsMTY4LjYzLjEyOS4xNiwuY29ycGdyb3VwLm5ldCwuYXp1cmUuY2xvdWQuY29ycCIgPj4gL2V0Yy9wcm9maWxlLmQvcHJveHkuc2gNCmNhdCA+PiAvZXRjL2Vudmlyb25tZW50IDw8RU9DDQpodHRwX3Byb3h5PSJodHRwX3Byb3h5PWh0dHBzOi8vMTAuNi4xNTYuMTMyOjgwOCINCmh0dHBzX3Byb3h5PSJodHRwc19wcm94eT1odHRwczovLzEwLjYuMTU2LjEzMjo4MDgiDQpub19wcm94eT0ibG9jYWxob3N0LDEyNy4wLjAuMSxsb2NhbGFkZHJlc3MsLmxvY2FsZG9tYWluLmNvbSINCkVPQw=="
  # custom_data = filebase64("cloud-init.txt")
  # custom_data = base64encode(templatefile("cloud-init.txt",{}))
  custom_data = filebase64("cloud-init.txt")
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
}
