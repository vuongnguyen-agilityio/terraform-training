# Create virtual network within the resource group
resource "azurerm_virtual_network" "default" {
    name                = "${var.prefix}_vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    tags = {
        environment = "Terraform Practice"
    }
}

# Create subnet
resource "azurerm_subnet" "default" {
    name                 = "${var.prefix}_subnet"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.${var.prefix}_vnet.name}"
    address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "default" {
    name                         = "${var.prefix}_public_ip"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Practice"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "default" {
    name                = "${var.prefix}_network_sg"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Practice"
    }
}

# Create network interface
resource "azurerm_network_interface" "default" {
    name                      = "${var.prefix}_network_nic"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"

    ip_configuration {
        name                          = "${var.prefix}_network_nic_cfg"
        subnet_id                     = "${azurerm_subnet.${var.prefix}_subnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.${var.prefix}_public_ip.id}"
    }

    tags = {
        environment = "Terraform Practice"
    }
}
