resource "azurerm_resource_group" "rg-hub" {
  provider = azurerm.dev_env
  name = var.rg_name
  location = var.rg_location
}
