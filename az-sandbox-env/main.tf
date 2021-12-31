#Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 5
  prefix      = "keyvault"
}

#create the resource  group
resource "azurerm_resource_group" "rg2" {
  name     = "ateam-resource-group"
  location = "australiaeast"
}
#Keyvault  Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  depends_on                  = [azurerm_resource_group.rg2]
  name                        = random_id.kvname.hex
  location                    = "australiaeast"
  resource_group_name         = "ateam-resource-group"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]
    storage_permissions = [
      "get",
    ]
  }
}


#Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 20
  special = true
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = random_password.vmpassword.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
}




#create the virtual  networks
resource "azurerm_virtual_network" "vnet1" {
  resource_group_name = azurerm_resource_group.rg2.name
  location            = "australiaeast"
  name                = "dev"
  address_space       = ["10.0.0.0/16"]
}

#create a subnet within the virtual  networks
resource "azurerm_subnet" "subnet1" {
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = "devsubnet"
  address_prefixes     = ["10.0.0.0/24"]
}

##create the network interface for the VM
resource "azurerm_public_ip" "pub_ip" {
  name                = "vmpubip"
  location            = "australiaeast"
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vmnic" {
  location            = "australiaeast"
  resource_group_name = azurerm_resource_group.rg2.name
  name                = "vmnic1"

  ip_configuration {
    name                          = "vmnic1-ipconf"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub_ip.id
  }
}






#Create VM
resource "azurerm_windows_virtual_machine" "dc01-vm" {
  name                = "dc01-vm"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = azurerm_resource_group.rg2.name
  location            = "australiaeast"
  size                = "Standard_A1_v2"
  admin_username      = "hariom"
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.vmnic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}