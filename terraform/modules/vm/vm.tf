resource "azurerm_network_interface" "nic" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_id}"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "azureadmin"
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = "azureadmin"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZuTP1n+yGJPqjou+yyy5Np2OsLVSG2OG0sX3WlTryhwHRGAiztgpiUc2hZNxINHbErX7Ipun6xm07lEi+9Bexl2195XsQCtW0PNdQfa3WvYFg41oz3RPuz72NVheN2W6KTrgCxxxbXqdGFXe0ipJP3OuE3fLApQ7bn4r/cFFYhwXO3fkM+MhoEXffNxWDuWV1QjPdyPNc69x+8nGja20AOWy7jPxns9uJTsNszDKmXmYw5VCcz6DlAI7G6Eqgp4iEgSRhd8xV7fquyrToH+AsD2AFXy47byLYYSc3F1My4INa5/jdYYVwP2Q2BscTRfkyTqtD6LaddAL/ObGeTW5cwZA3nJMUVPtbnYByBMJeSWpW7et0HwXLiaCsNL8i4RTUw0ClLSE9QMbq78Zxxxl0UdD+0mAgiHe3P8p8gt0ThOxIN2iUcnEMk86Wh+WUZXcqHOOqZw11A82DVUySKW2JhjNR3+QWj+pXO/HHsg9wyF6oCmwggBkNWeSZGJ3ZYN8= saurabhbhardwaj@MacBook-Pro.local"

  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
