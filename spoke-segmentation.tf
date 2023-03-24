resource "aviatrix_segmentation_security_domain" "prod-security-domain" {
  domain_name = "Prod"
}

resource "aviatrix_segmentation_security_domain" "dev-security-domain" {
  domain_name = "Dev"
}

resource "aviatrix_segmentation_security_domain_association" "spoke1-security-domain-association" {
  transit_gateway_name = var.it-az-usw2-transit-name
  security_domain_name = aviatrix_segmentation_security_domain.prod-security-domain.domain_name
  attachment_name      = module.az-usw2-spoke-1.spoke_gateway.gw_name
}

resource "aviatrix_segmentation_security_domain_association" "spoke2-security-domain-association" {
  transit_gateway_name = var.it-az-usw2-transit-name
  security_domain_name = aviatrix_segmentation_security_domain.prod-security-domain.domain_name
  attachment_name      = join(":", [var.azure_access_account_name, var.az-native-vnet-1, aviatrix_vpc.az-native-vnet-1.resource_group, data.azurerm_virtual_network.az-native-vnet-1.guid])
}

resource "aviatrix_segmentation_security_domain_association" "native-spoke1-security-domain-association" {
  transit_gateway_name = var.it-az-usw2-transit-name
  security_domain_name = aviatrix_segmentation_security_domain.dev-security-domain.domain_name
  attachment_name      = module.az-usw2-spoke-2.spoke_gateway.gw_name
}

resource "aviatrix_segmentation_security_domain_association" "native-spoke2-security-domain-association" {
  transit_gateway_name = var.it-az-usw2-transit-name
  security_domain_name = aviatrix_segmentation_security_domain.dev-security-domain.domain_name
  attachment_name      = join(":", [var.azure_access_account_name, var.az-native-vnet-2, aviatrix_vpc.az-native-vnet-2.resource_group, data.azurerm_virtual_network.az-native-vnet-2.guid])
}
