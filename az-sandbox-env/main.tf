locals {
  env    = "sandbox"
  prefix = "sandbox-"
}
module "azure-resource-group" {
  source       = "../modules/azure-resource-group"
  rsg_name     = var.rsg_name
  rsg_location = var.rsg_location
}
#Get provider config
data "azurerm_client_config" "current" {}

module "zurerm-key-vault" {
  source     = "../modules/azure-key-vault"
  depends_on = [module.azure-resource-group]

  name                        = "${local.prefix}dc01-vm"
  location                    = module.azure-resource-group.azure_resource_group_location
  resource_group_name         = module.azure-resource-group.azurerm_resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = var.sku_kb
  object_id                   = data.azurerm_client_config.current.object_id
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
module "random-password" {
  source  = "../modules/random-password"
  length  = 20
  special = true
}

module "azure-key-vault-secret" {
  source     = "../modules/azure-key-vault-secret"
  depends_on = [module.zurerm-key-vault]

  name         = "${local.prefix}vmpassword"
  value        = module.random-password.zurerm-random-password-result
  key_vault_id = module.zurerm-key-vault.zurerm-key-vault-id
}

module "azure-virtual-network" {
  source              = "../modules/azure-virtual-network"
  resource_group_name = module.azure-resource-group.azurerm_resource_group_name
  location            = module.azure-resource-group.azure_resource_group_location
  name                = "vnet-${local.env}"
  address_space       = var.vnet_address_space
}

module "azurerm-subnet" {
  source               = "../modules/azurerm-subnet"
  resource_group_name  = module.azure-resource-group.azurerm_resource_group_name
  virtual_network_name = module.azure-virtual-network.zurerm-virtual-network-name
  name                 = "snet-${local.env}"
  address_prefixes     = ["10.0.0.0/24"]
}

module "azure-public-ip" {
  source              = "../modules/azure-public-ip"
  name                = "pip-${var.rsg_name}-${local.prefix}-001"
  location            = module.azure-resource-group.azure_resource_group_location
  resource_group_name = module.azure-resource-group.azurerm_resource_group_name
  allocation_method   = "Dynamic"
}

module "azure-network-interface" {
  source                        = "../modules/azure-network-interface"
  location                      = module.azure-resource-group.azure_resource_group_location
  resource_group_name           = module.azure-resource-group.azurerm_resource_group_name
  name                          = "${local.prefix}nic"
  configuration_name            = "niccfg-${local.env}"
  subnet_id                     = module.azurerm-subnet.zurerm-subnet-id
  private_ip_address_allocation = "Dynamic"
  public_ip_address_id          = module.azure-public-ip.azure-public-ip-id
}

#Create VM  module
module "azure-windows-vm" {
  source     = "../modules/azure-windows-vm"
  depends_on = [module.zurerm-key-vault]

  name                  = "${local.prefix}vm-01"
  resource_group_name   = module.azure-resource-group.azurerm_resource_group_name
  location              = module.azure-resource-group.azure_resource_group_location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = module.azure-key-vault-secret.zurerm-key-vault-secret-password
  network_interface_ids = [module.azure-network-interface.azure-network-interface-id]
  caching               = "ReadWrite"
  storage_account_type  = var.disk_type
  osconfig              = var.osconfig
}