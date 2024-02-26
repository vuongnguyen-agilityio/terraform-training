# Create virtual network
resource "azurerm_virtual_network" "storagemanagementnetwork" {
    name                = "storageManagementVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    tags = {
        environment = "Terraform Practice"
    }
}

# Create subnet
resource "azurerm_subnet" "storagemanagementsubnet" {
    name                 = "storageManagementSubnet"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.storageManagementNetWork.name}"
    address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "storagemanagementpublicip" {
    name                         = "storageManagementPublicIP"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Practice"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "storagemanagementsg" {
    name                = "storageManagementNetWorkSecurityGroup"
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
resource "azurerm_network_interface" "storagemanagementnic" {
    name                      = "storageManagementNetWorkNIC"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"

    ip_configuration {
        name                          = "storageManagementNetWorkNicConfiguration"
        subnet_id                     = "${azurerm_subnet.storagemanagementsubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.storagemanagementpublicip.id}"
    }

    tags = {
        environment = "Terraform Practice"
    }
}
