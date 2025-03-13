resource "azurerm_network_security_group" "nsg-snet-hub-mgmt-01-cus" {
    provider = azurerm.dev_env
  name                = "nsg-snet-hub-mgmt-01-cus"
  location            = azurerm_resource_group.rg-hub.location
  resource_group_name = azurerm_resource_group.rg-hub.name

  security_rule {
    name                       = "Allowsshtovm"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "allow-winrm-http"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsg-snet-hub-mgmt-01-cus" {
    provider = azurerm.dev_env
  subnet_id                 = data.azurerm_subnet.snet_hub_mgmt_01_cus.id
  network_security_group_id = azurerm_network_security_group.nsg-snet-hub-mgmt-01-cus.id
}