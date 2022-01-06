variable "name" {
  type        = string
  description = "name of vm"
}
variable "resource_group_name" {
  type        = string
  description = "name of vm resource group"
}
variable "location" {
  type        = string
  description = "vm location"
}
variable "admin_username" {
  type        = string
  description = "user name of vm"
}
variable "admin_password" {
  type        = string
  sensitive   = true
  description = "password of vm"
}
variable "network_interface_ids" {
  type        = list(string)
  description = "network interface ids"
}
variable "caching" {
  type        = string
  description = "vm caching"
}
variable "storage_account_type" {
  type        = string
  description = "vm strorage account type"
}

variable "size" {
  type        = string
  description = "vm size"
}

variable "osconfig" {
  type        = map(string)
  description = "os configuration"
}