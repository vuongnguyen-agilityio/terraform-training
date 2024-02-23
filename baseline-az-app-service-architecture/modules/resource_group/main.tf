# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "storageManagementResourceGroup" {
    name     = "storageManagementResourceGroup"
    location = "${var.location}"

    tags = {
        environment = "Terraform Practice"
    }
}
