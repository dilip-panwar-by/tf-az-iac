resource "azurerm_resource_group" "vm-rg" {
  name     = var.rsg_name
  location = var.rsg_location
}
