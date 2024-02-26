output "id" {
  value = azurerm_virtual_network.default.id
}

output "name" {
  value = azurerm_virtual_network.default.name
}

output "nic" {
  value = azurerm_network_interface.default.id
}
