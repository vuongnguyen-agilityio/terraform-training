# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                = "tfmystorageaccount"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_storage_container" "mystoragecontainer" {
  name                  = "vhds"
  storage_account_name  = "${azurerm_storage_account.mystorageaccount.name}"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "mystorageblob" {
  name = "sample.vhd"

  storage_account_name   = "${azurerm_storage_account.mystorageaccount.name}"
  storage_container_name = "${azurerm_storage_container.mystoragecontainer.name}"

  type = "Page"
  size = 5120
}