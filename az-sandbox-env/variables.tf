variable "rsg_name" {
  type        = string
  description = "Name of the resource group environment"
}

variable "rsg_location" {
  type        = string
  description = "Azure location of terraform server environment"
  default     = "westus2"
}
variable "admin_username" {
  type        = string
  description = "Administrator username for server"
}

variable "disk_type" {
  type        = string
  description = " Disk storage type "
  default     = "StandardSSD_LRS"
}

variable "vnet_address_space" {
  type        = list(any)
  description = "Address space for Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "sku_kb" {
  description = "which SKU do you want (options: Standard,Premium)"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["standard", "Premium"], var.sku_kb)
    error_message = "Argument 'sku' must one of 'Standard', or 'Premium'."
  }
}

variable "vm_size" {
  type        = string
  description = "Size of VM"
  default     = "Standard_A1_v2"
}

variable "osconfig" {
  type        = map(string)
  description = "values of vm os"
}

