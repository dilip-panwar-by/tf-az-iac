output "azurerm_resource_group_name" {
  description = "resource group name"
  value       = azurerm_resource_group.vm-rg.name
}
output "azure_resource_group_location" {
  description = "resource group location"
  value       = azurerm_resource_group.vm-rg.location
}