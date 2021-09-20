resource "azurerm_network_security_group" "myterraformnsg" {
    name                = var.network_security_group_name
    location            = var.network_security_group_location
    resource_group_name = var.network_security_group_resource_group_name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}