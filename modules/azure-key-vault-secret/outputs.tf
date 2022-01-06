output "zurerm-key-vault-secret-password" {
  description = ""
  value       = azurerm_key_vault_secret.vmpassword.value
}
