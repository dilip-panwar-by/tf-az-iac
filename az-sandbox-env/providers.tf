terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.90.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "env-storage-rsg"
    #rsg-comman-ftr
    storage_account_name = "storageaccountforenv"
    container_name       = "storage-sandbox-env"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


