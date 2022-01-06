variable "resource_group_name" {
  type        = string
  description = "resource group name"
}
variable "virtual_network_name" {
  type        = string
  description = "name of virtual network"
}
variable "name" {
  type        = string
  description = "name of subnet"
}
variable "address_prefixes" {
  type        = list(string)
  description = "address prefix"

}