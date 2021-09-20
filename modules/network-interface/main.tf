resource "azurerm_network_interface" "myterraformnic" {
    name                      = var.network_interface_name
    location                  = var.network_interface_location
    resource_group_name       = var.network_interface_resource_group_name

    ip_configuration {
        name                          = var.network_interface_configuration_name
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = var.private_IP_allocation_method
    }

    tags = {
        environment = "Terraform Demo"
    }
}
