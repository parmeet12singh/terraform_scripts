terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

module "azure-resource-group" {
  source = "./modules/resource-group"
  
  resource_group_name = "Module-RG-Group"
  resource_group_location = "westeurope"
}

module "azure-vnet" {
  source = "./modules/vnet"
    
  virtual_network_name = "Module-VNet"
  virtual_network_address_space = "10.0.0.0/16"    
  virtual_network_resource_group = module.azure-resource-group.resource_group_name
  virtual_network_location = module.azure-resource-group.resource_group_location
}

module "azure-subnet" {
  source = "./modules/subnet"

  subnet_name = "Module-Subnet"
  subnet_resource_group = module.azure-vnet.virtual_network_resource_group
  virtual_network_name = module.azure-vnet.virtual_network_name
  subnet_prefix = "10.0.1.0/24"
}

module "azure-nsg" {
  source = "./modules/nsg"

  network_security_group_name = "Module-NSG"
  network_security_group_resource_group_name = module.azure-resource-group.resource_group_name
  network_security_group_location = module.azure-resource-group.resource_group_location
}

module "azure-nic" {
  source = "./modules/network-interface"

  network_interface_name = "Module-NIC"
  network_interface_resource_group_name = module.azure-resource-group.resource_group_name
  network_interface_location = module.azure-resource-group.resource_group_location
  subnet_id = module.azure-subnet.subnet_id
  network_interface_configuration_name = "Module-NIC-Config"
  private_IP_allocation_method = "Dynamic"
}

resource "azurerm_network_interface_security_group_association" "myterraform-nic-nsg-association" {

  network_interface_id      = module.azure-nic.nic_id
  network_security_group_id = module.azure-nsg.nsg_id
}

module "azure-storage-account" {
  source = "./modules/storage-account"
  
  storage_account_name = "modulestorageaccount"
  storage_account_resource_group_name = module.azure-resource-group.resource_group_name
  storage_account_location = module.azure-resource-group.resource_group_location
  storage_account_tier = "Standard"
  storage_account_replication_type = "LRS"
}

module "azure-vm" {
  source = "./modules/vm"

  virtual_machine_name = "Module-VM"
  virtual_machine_resource_group_name = module.azure-resource-group.resource_group_name
  virtual_machine_location = module.azure-resource-group.resource_group_location
  vm_network_interface_id = module.azure-nic.nic_id
  vm_size = "Standard_B1ls"
  vm_computer_name  = "myvm"
  vm_admin_username = "dradmin"
  vm_admin_password = "Pwc##12345678"
  vm_storage-account-primary-blob-endpoint = module.azure-storage-account.storage-account-primary-blob-endpoint
}