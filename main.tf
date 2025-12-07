terraform {
  required_version = ">= 1.7.0"

  # Remote backend so your laptop and GitHub Actions share the same state
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-vijay" # <- RG you created for state
    storage_account_name = "vijaytfstate123"  # <- your storage account name
    container_name       = "tfstate"          # <- container you created
    key                  = "project1.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Get info about the current Azure identity (who you logged in as)
data "azurerm_client_config" "current" {}

# Common tags used on all resources
locals {
  common_tags = {
    Project = "Genomics"
    Owner   = var.project_owner
    Env     = var.environment
  }
}

# Resource Group for the entire project
resource "azurerm_resource_group" "rg" {
  name     = "rg-genomics"
  location = var.location
  tags     = local.common_tags
}
