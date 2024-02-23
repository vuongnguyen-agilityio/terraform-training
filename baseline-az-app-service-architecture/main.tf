# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "./modules/resource_group"
  location = var.location
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  location            = var.location
  resource_group_name = module.resource_group.name
}
