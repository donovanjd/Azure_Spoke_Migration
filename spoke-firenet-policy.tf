resource "aviatrix_transit_firenet_policy" "it-az-usw2-spoke-1-policy" {
  transit_firenet_gateway_name = var.it-az-usw2-transit-name
  inspected_resource_name      = "SPOKE:${module.az-usw2-spoke-1.spoke_gateway.gw_name}"
}

resource "aviatrix_transit_firenet_policy" "it-az-usw2-spoke-2-policy" {
  transit_firenet_gateway_name = var.it-az-usw2-transit-name
  inspected_resource_name      = "SPOKE:${module.az-usw2-spoke-2.spoke_gateway.gw_name}"
}

resource "aviatrix_transit_firenet_policy" "az-native-vnet-1-policy" {
  transit_firenet_gateway_name = var.it-az-usw2-transit-name
  inspected_resource_name      = "ARM_SPOKE:${var.azure_access_account_name}:${var.az-native-vnet-1}:${aviatrix_vpc.az-native-vnet-1.resource_group}:${data.azurerm_virtual_network.az-native-vnet-1.guid}"
}

resource "aviatrix_transit_firenet_policy" "az-native-vnet-2-policy" {
  transit_firenet_gateway_name = var.it-az-usw2-transit-name
  inspected_resource_name      = "ARM_SPOKE:${var.azure_access_account_name}:${var.az-native-vnet-2}:${aviatrix_vpc.az-native-vnet-2.resource_group}:${data.azurerm_virtual_network.az-native-vnet-2.guid}"

}