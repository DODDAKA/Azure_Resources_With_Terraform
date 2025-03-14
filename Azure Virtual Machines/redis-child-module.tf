
module "redis-dev" {
  source = ".//modules/redis-module"
  rg-name = azurerm_resource_group.rg-hub.name
  rg-location = azurerm_resource_group.rg-hub.location
  redis-name = var.redis-name
  redis-capacity = var.redis-capacity
  redis-tier = var.redis-tier
  redis-sku_name = var.redis-sku_name
  non_ssl_port_enabled = var.non_ssl_port_enabled
  minimum_tls_version = var.minimum_tls_version
  providers = {
    azurerm =azurerm.dev_env
  }

}