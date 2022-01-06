variable "name" {
  type        = string
  description = "name of interface"
}
variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}
variable "location" {
  type        = string
  description = "location of network interface"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}
variable "private_ip_address_allocation" {
  type        = string
  description = "private ip allocation"
}
variable "public_ip_address_id" {
  type        = string
  description = "public ip address id"
}
variable "configuration_name" {
  type        = string
  description = "name of ip configuration name"
}