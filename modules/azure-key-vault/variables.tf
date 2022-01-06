variable "name" {
  type        = string
  description = "name of key-vault"
}
variable "location" {
  type        = string
  description = "loaction of key-vault"
}
variable "resource_group_name" {
  type        = string
  description = "name resource group"
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "enabled disk encryption"
}

variable "tenant_id" {
  type        = string
  description = "tenant id"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "delete retention days"
}

variable "purge_protection_enabled" {
  type        = bool
  description = " purge protection enable"
}
variable "sku_name" {
  type        = string
  description = "sku name"

}
variable "object_id" {
  type        = string
  description = "object id"
}
variable "key_permissions" {
  type        = list(string)
  description = "key permission"
}
variable "secret_permissions" {
  type        = list(string)
  description = "secret permission"
}

variable "storage_permissions" {
  type        = list(string)
  description = "storage permission"
}

      