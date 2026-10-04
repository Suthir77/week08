terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "week10tfrgsuthi"
    storage_account_name = "week10tfstatesuthi"
    container_name       = "tfstate"
    key                  = "week10.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "sit722" {
  name     = "week10rgsuthi"
  location = "australiaeast"
}

resource "azurerm_kubernetes_cluster" "sit722" {
  name                = "week10akssuthi"
  location            = azurerm_resource_group.sit722.location
  resource_group_name = azurerm_resource_group.sit722.name
  dns_prefix          = "week10akssuthi"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}
