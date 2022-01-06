variable "rsg_name" {
  type        = string
  description = "Name of the resource group environment"
}

variable "rsg_location" {
  type        = string
  description = "Azure location of terraform server environment"
  default     = "westus2"

}