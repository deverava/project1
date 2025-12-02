# Virtual Network for research workloads
resource "azurerm_virtual_network" "vnet_research" {
  name                = "vnet-research"
  address_space       = ["10.10.0.0/20"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

# Backend subnet for private endpoints (Storage, Key Vault)
resource "azurerm_subnet" "sn_backend" {
  name                 = "sn-backend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_research.name
  address_prefixes     = ["10.10.0.0/24"]
}

# Jumphost subnet for admin VM
resource "azurerm_subnet" "sn_jumphost" {
  name                 = "sn-jumphost"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_research.name
  address_prefixes     = ["10.10.1.0/24"]
}

# Future HPC/AKS subnet
resource "azurerm_subnet" "sn_hpc" {
  name                 = "sn-hpc"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_research.name
  address_prefixes     = ["10.10.2.0/24"]
}
