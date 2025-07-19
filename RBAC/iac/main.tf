terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
  subscription_id = "66b3f5b6-8e0e-40da-bb11-2e607df4cf26"
}

provider "azuread" {}

module "rbac_assignment" {
  source           = "../modules/rbac_assignment"
  principal_access = var.principal_access
  resource_names   = var.resource_names
}