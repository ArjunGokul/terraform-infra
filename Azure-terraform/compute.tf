resource "azurerm_linux_virtual_machine" "kk-vm" {
  for_each            = toset(var.linux_names)
  name                = each.value
  location            = data.azurerm_resource_group.my-rg.location
  resource_group_name = data.azurerm_resource_group.my-rg.name
  size                = "Standard_D4alds_v6"
  admin_username      = "adminuser"
  admin_password      = "Kodekloudmy-rg1!"

  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.kk-nic[each.value].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    size_gb              = 100
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.kk-pip[each.value].ip_address
      user     = "adminuser"
      password = "Kodekloudmy-rg1!"
    }
  }
  tags = merge(local.common_tags, {
    Name = "nginx-vm"
  })
}

