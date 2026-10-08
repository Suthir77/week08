terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote state, so every pipeline run sees what the previous run built.
  backend "azurerm" {
    resource_group_name  = "week10tfrgsuthi"
    storage_account_name = "week10tfstatesuthi"
    container_name       = "tfstate"
    key                  = "koalatech.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
