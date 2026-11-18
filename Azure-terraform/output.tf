output "vm_public_ip" {
  value = {
    for key, pip in azurerm_public_ip.kk-pip :
    key => pip.ip_address
  }
}