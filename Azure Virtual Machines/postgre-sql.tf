resource "azurerm_private_dns_zone" "psqlpdns" {
    provider = azurerm.dev_env
  name                = "psqlpdns.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg-hub.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
    provider = azurerm.dev_env
  name                  = "exampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.psqlpdns.name
  virtual_network_id    = azurerm_virtual_network.vnethub["vnet-cus-hub"].id
  resource_group_name   = azurerm_resource_group.rg-hub.name
  depends_on            = [azurerm_subnet.snets]
}

resource "azurerm_postgresql_flexible_server" "psql-cus-dev" {
    provider = azurerm.dev_env
  name                          = "psql-cus-dev"
  resource_group_name           = azurerm_resource_group.rg-hub.name
  location                      = azurerm_resource_group.rg-hub.location
  version                       = "15"
  delegated_subnet_id           = data.azurerm_subnet.snet-hub-db-01-cus.id
  private_dns_zone_id           = azurerm_private_dns_zone.psqlpdns.id
  public_network_access_enabled = false
  administrator_login           = "psqladmin"
  administrator_password        = "H@Sh1CoR3!"
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"
  backup_retention_days = "7"

  sku_name   = "GP_Standard_D2s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
  geo_redundant_backup_enabled = false ### changing this cause new resource creation

}

