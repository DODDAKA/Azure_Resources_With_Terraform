
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.21.1" # Use the same or compatible version as the root module
    }
  }
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "example" {
  name                 = var.redis-name
  location             = var.rg-location
  resource_group_name  = var.rg-name
  capacity             = var.redis-capacity
  family               = var.redis-tier
  sku_name             = var.redis-sku_name
  non_ssl_port_enabled = var.non_ssl_port_enabled
  minimum_tls_version  = var.minimum_tls_version

  redis_configuration {
  }
}
