terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}



  # Explicit subscription
  subscription_id = "80affa15-e9c9-4b08-b835-15cd37551eed"
}
