variable "name" {
  type        = string
  description = "key-vault secret name"
}
variable "value" {
  type        = string
  description = "value of random password"
}

variable "key_vault_id" {
  type        = string
  description = "id of key-vault"
}