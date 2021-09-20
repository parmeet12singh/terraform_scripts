output "virtual_network_name" {
  value = azurerm_virtual_network.myterraformnetwork.name
}
output "virtual_network_address_space" {
  value = azurerm_virtual_network.myterraformnetwork.address_space
}
output "virtual_network_location" {
  value = azurerm_virtual_network.myterraformnetwork.location
}
output "virtual_network_resource_group" {
  value = azurerm_virtual_network.myterraformnetwork.resource_group_name
}