resource "azurerm_service_plan" "storage_management" {
    name                = "${var.prefix}-asp"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    os_type             = "Linux"
    sku_name            = "F1"
}

resource "azurerm_linux_web_app" "storage_management" {
  name                = "${var.prefix}_web_app"
  resource_group_name = azurerm_resource_group.storage_management.name
  location            = azurerm_service_plan.storage_management.location
  service_plan_id     = azurerm_service_plan.storage_management.id

  site_config {}
}