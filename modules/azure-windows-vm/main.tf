resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = var.network_interface_ids
  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = lookup(var.osconfig, "publisher", null)
    offer     = lookup(var.osconfig, "offer", null)
    sku       = lookup(var.osconfig, "sku", null)
    version   = lookup(var.osconfig, "version", null)
  }
}

