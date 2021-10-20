resource "azurerm_express_route_circuit" "myterraformexpressroute" {
  name                  = var.express_route_name
  location            = var.express_route_location
  resource_group_name = var.express_route_resource_group_name
  service_provider_name = var.express_route_service_provider_name
  peering_location      = var.express_route_peering_location
  bandwidth_in_mbps     = var.express_route_bandwidth_in_mbps

  sku {
    tier   = var.express_route_sku_tier
    family = var.express_route_sku_family
  }

  tags = {
    environment = "Production"
  }
}