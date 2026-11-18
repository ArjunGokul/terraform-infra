resource "azurerm_managed_disk" "kk-data-disk" {
  for_each             = toset(var.linux_names)
  name                 = "kk-data-disk-${each.value}"
  location             = data.azurerm_resource_group.my-rg.location
  resource_group_name  = data.azurerm_resource_group.my-rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 50

  tags = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "kk-data-disk-attachment" {
  for_each           = toset(var.linux_names)
  managed_disk_id    = azurerm_managed_disk.kk-data-disk[each.value].id
  virtual_machine_id = azurerm_linux_virtual_machine.kk-vm[each.value].id

  lun     = 0
  caching = "ReadWrite"
}