
output "azure-network-interface-id" {
  description = "azure-key-vault-id"
  value       = azurerm_network_interface.vmnic.id
}
