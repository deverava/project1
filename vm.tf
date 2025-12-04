# Simple NSG just for the VM NIC (allows RDP)
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "nsg-vm-basic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

resource "azurerm_network_security_rule" "vm_rdp" {
  name                        = "Allow-RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "0.0.0.0/0" # later you can change to your home IP
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
}

# Public IP for the VM
resource "azurerm_public_ip" "vm_pip" {
  name                = "pip-vm-basic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

# NIC in sn-jumphost subnet
resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-vm-basic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.sn_jumphost.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

# Attach NSG to NIC (so RDP works)
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

# Windows VM
resource "azurerm_windows_virtual_machine" "vm_basic" {
  name                = "vm-basic-jumphost" # Azure name (can be long)
  computer_name       = "vmjump01"          # Windows internal name (must be <= 15)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"

  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  os_disk {
    name                 = "osdisk-vm-basic"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = local.common_tags
}
