
module "az-usw2-spoke-1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.3"


  cloud            = "Azure"
  name             = "it-az-usw2-spoke-1"
  cidr             = var.it-az-usw2-spoke-1-cidr
  use_existing_vpc = false
  ha_gw            = true
  region           = "Australia East"
  account          = var.azure_access_account_name
  instance_size    = var.spoke_instance_size
  insane_mode      = true
  inspection       = false
  transit_gw       = var.it-az-usw2-transit-name
}

module "az-usw2-spoke-2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.3"


  cloud            = "Azure"
  name             = "it-az-usw2-spoke-2"
  cidr             = var.it-az-usw2-spoke-2-cidr
  use_existing_vpc = false
  ha_gw            = true
  region           = "Australia East"
  account          = var.azure_access_account_name
  instance_size    = var.spoke_instance_size
  insane_mode      = true
  inspection       = false
  transit_gw       = var.it-az-usw2-transit-name
}

resource "aviatrix_vpc" "az-native-vnet-1" {
  cloud_type           = 8
  account_name         = var.azure_access_account_name
  region               = "Australia East"
  name                 = var.az-native-vnet-1
  cidr                 = var.native-vnet-1-cidr
  aviatrix_firenet_vpc = false
}

resource "aviatrix_vpc" "az-native-vnet-2" {
  cloud_type           = 8
  account_name         = var.azure_access_account_name
  region               = "Australia East"
  name                 = var.az-native-vnet-2
  cidr                 = var.native-vnet-2-cidr
  aviatrix_firenet_vpc = false
}

data "azurerm_virtual_network" "az-native-vnet-1" {
  name                = var.az-native-vnet-1
  resource_group_name = aviatrix_vpc.az-native-vnet-1.resource_group
}

data "azurerm_virtual_network" "az-native-vnet-2" {
  name                = var.az-native-vnet-2
  resource_group_name = aviatrix_vpc.az-native-vnet-2.resource_group
}

resource "aviatrix_azure_spoke_native_peering" "az-native-vnet-1" {
  transit_gateway_name = var.it-az-usw2-transit-name
  spoke_account_name   = var.azure_access_account_name
  spoke_region         = "West US"
  spoke_vpc_id         = join(":", [var.az-native-vnet-1, aviatrix_vpc.az-native-vnet-1.resource_group, data.azurerm_virtual_network.az-native-vnet-1.guid])
}


resource "aviatrix_azure_spoke_native_peering" "az-native-vnet-2" {
  transit_gateway_name = var.it-az-usw2-transit-name
  spoke_account_name   = var.azure_access_account_name
  spoke_region         = "West US"
  spoke_vpc_id         = join(":", [var.az-native-vnet-2, aviatrix_vpc.az-native-vnet-2.resource_group, data.azurerm_virtual_network.az-native-vnet-2.guid])
}


