output "id" {
  value = "${azurerm_virtual_network.storagemanagementnetwork.id}"
}

output "name" {
  value = "${azurerm_virtual_network.storagemanagementnetwork.name}"
}

output "nic" {
  value = "${azurerm_network_interface.storagemanagementnic.id}"
}