terraform {
  required_providers {
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "2.21.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.76.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
  subscription_id            = var.azure_subscription_id
  client_id                  = var.azure_client_id
  client_secret              = var.azure_client_secret
  tenant_id                  = var.azure_tenant_id
}

provider "aviatrix" {
  controller_ip = ""
  username      = "admin"
  password      = ""
}
