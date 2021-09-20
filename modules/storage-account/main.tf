resource "azurerm_storage_account" "myterraformstorageaccount" {
    
    name                        = var.storage_account_name
    resource_group_name         = var.storage_account_resource_group_name
    location                    = var.storage_account_location
    account_tier                = var.storage_account_tier
    account_replication_type    = var.storage_account_replication_type

    tags = {
        environment = "Terraform Demo"
    }
}