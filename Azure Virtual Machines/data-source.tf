data "azurerm_subnet" "snet_hub_mgmt_01_cus" {
    provider = azurerm.dev_env
  name                 = "snet-hub-mgmt-01-cus"
  virtual_network_name = "vnet-cus-hub"  # Replace with the name of your virtual network
  resource_group_name  = var.rg_name
  depends_on = [azurerm_subnet.snets] #################################################################################
}

data "azurerm_subnet" "snet-hub-appgw-01-cus" {
    provider = azurerm.dev_env
  name                 = "snet-hub-appgw-01-cus"
  virtual_network_name = "vnet-cus-hub"  # Replace with the name of your virtual network
  resource_group_name  = var.rg_name
  depends_on = [azurerm_subnet.snets] #################################################################################
}

data "azurerm_subnet" "snet-hub-db-01-cus" {
  provider = azurerm.dev_env
  name = "snet-hub-db-01-cus"
  virtual_network_name = "vnet-cus-hub"  # Replace with the name of your virtual network
  resource_group_name  = var.rg_name
  depends_on = [azurerm_subnet.snets]
}