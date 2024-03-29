# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.93.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

module "resource_group" {
  source   = "./modules/resource_group"
  location = var.location
  prefix   = var.prefix
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  location            = var.location
  resource_group_name = module.resource_group.name
  prefix              = var.prefix
}

module "app_service" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = module.resource_group.name
  prefix              = var.prefix

}