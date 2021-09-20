resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = var.virtual_machine_name
    location              = var.virtual_machine_location
    resource_group_name   = var.virtual_machine_resource_group_name
    network_interface_ids = [var.vm_network_interface_id]
    size                  = var.vm_size

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = var.vm_computer_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
    disable_password_authentication = false

    boot_diagnostics {
        storage_account_uri = var.vm_storage-account-primary-blob-endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}