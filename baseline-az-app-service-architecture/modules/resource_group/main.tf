# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "storage_management" {
    name     = "${var.prefix}_resource_group"
    location = "${var.location}"

    tags = {
        environment = "Terraform Practice"
    }
}
