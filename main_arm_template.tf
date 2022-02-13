terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "ARM_Template_Deployment"
  location = "westeurope"
}
resource "azurerm_template_deployment" "arm" {
  name                = "arm"
  resource_group_name = azurerm_resource_group.rg.name
  parameters_body = jsonencode({
    serverFarmName = { value = var.serverFarmName }
    webAppName = { value = var.webAppName }
  })
  template_body = file("azuredeploy.json")

  deployment_mode = "Incremental"
}
