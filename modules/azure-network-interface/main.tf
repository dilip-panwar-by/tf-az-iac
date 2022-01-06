
resource "azurerm_network_interface" "vmnic" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  ip_configuration {
    name                          = var.configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = var.public_ip_address_id
  }
}