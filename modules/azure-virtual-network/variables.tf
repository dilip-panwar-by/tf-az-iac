variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}
variable "location" {
  type        = string
  description = "location of vnet"

}
variable "name" {
  type        = string
  description = "name of vnet"
}
variable "address_space" {
  type        = list(string)
  description = "Address space for Virtual Network"
  default     = ["10.0.0.0/16"]
}
