output "subnet_name" {
  value = azurerm_subnet.myterraformsubnet.name
}
output "subnet_resource_group" {
  value = azurerm_subnet.myterraformsubnet.resource_group_name
}
output "virtual_network_name" {
  value = azurerm_subnet.myterraformsubnet.virtual_network_name
}
output "subnet_prefix" {
  value = azurerm_subnet.myterraformsubnet.address_prefixes
}
output "subnet_id" {
  value = azurerm_subnet.myterraformsubnet.id
}