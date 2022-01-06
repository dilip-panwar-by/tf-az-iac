
output "azure-public-ip-id" {
  description = "id of azurerm public ip"
  value       = azurerm_public_ip.pub_ip.id
}
