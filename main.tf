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
