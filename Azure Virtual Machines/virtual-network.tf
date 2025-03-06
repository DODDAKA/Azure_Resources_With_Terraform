resource "azurerm_virtual_network" "vnethub" {
  provider = azurerm.dev_env
  for_each = var.vnet_hub
  name                = each.key
  address_space       = each.value.address_space
  location            = azurerm_resource_group.rg-hub.location
  resource_group_name = azurerm_resource_group.rg-hub.name
}

# resource "azurerm_subnet" "snets" {
#   provider = azurerm.dev_env
#   for_each = { for k, v in var.vnet_hub : k => v.subnets }
#   name                 = each.value.snet_name
#   resource_group_name  = azurerm_resource_group.rg-hub.name
#   virtual_network_name = azurerm_virtual_network.vnethub[each.key].name
#   address_prefixes     = ["${each.value.snet_range}"]

# }

resource "azurerm_subnet" "snets" {
  provider = azurerm.dev_env
  for_each = {
    for subnet_key, subnet in flatten([
      for vnet_key, vnet in var.vnet_hub : [
        for subnet_key, subnet in vnet.subnets : {
          vnet_key    = vnet_key
          subnet_key  = subnet_key
          subnet_name = subnet.snet_name
          subnet_range = subnet.snet_range
        }
      ]
    ]) : "${subnet.vnet_key}.${subnet.subnet_key}" => subnet
  }

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.rg-hub.name
  virtual_network_name = azurerm_virtual_network.vnethub[each.value.vnet_key].name
  address_prefixes     = each.value.subnet_range
}