resource "azurerm_service_plan" "storage_management" {
  name                = "${var.prefix}_sp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "storage_management" {
  name                = "storagemanagementwebapp"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.storage_management.id

  site_config {
    always_on = false #always_on must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.

    application_stack {
      docker_image_name        = "vuongnguyenasnet/dotnet-practice:latest"
      docker_registry_url      = "https://registry.hub.docker.com/v2"
    }
  }

}
