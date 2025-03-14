
resource "azurerm_public_ip" "agwpip" {
    provider = azurerm.dev_env
  name                = "agwpip"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  allocation_method   = "Static"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.vnethub["vnet-cus-hub"].name}-rdrcfg"
}

resource "azurerm_application_gateway" "agw-cus-dev" {
    provider = azurerm.dev_env
  name                = "agw-cus-dev"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    //capacity = 2
  }

  autoscale_configuration{
    min_capacity = 1
    max_capacity = 4
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.snet-hub-appgw-01-cus.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agwpip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    //path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
