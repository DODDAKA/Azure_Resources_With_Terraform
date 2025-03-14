rg_name = "rg-hub"
rg_location = "centralus"
vnet_hub = {
  vnet-cus-hub = {
    address_space = ["10.14.0.0/20"],
    subnets={
        GatewaySubnet={
            snet_name= "GatewaySubnet",
            snet_range = ["10.14.0.0/24"]
        }
        AzureFirewallSubnet={
            snet_name = "AzureFirewallSubnet"
            snet_range = ["10.14.1.0/26"]
        }
        snet-hub-acr-01-cus={
            snet_name = "snet-hub-db-01-cus"
            snet_range = ["10.14.1.64/26"]
        }
        snet-hub-mgmt-01-cus ={
            snet_name = "snet-hub-mgmt-01-cus"
            snet_range = ["10.14.1.128/25"]
        }
        snet-hub-appgw-01-cus ={
            snet_name = "snet-hub-appgw-01-cus"
            snet_range = ["10.14.2.0/24"]
        }
        AzureBastionSubnet ={
            snet_name ="AzureBastionSubnet"
            snet_range = ["10.14.3.0/26"]
        }
    }
  }
}

vms_hub ={
    vm-win-cus-hub={
      size = "Standard_F2"
      admin_username      = "adminuser"
      storage_account_type = "Standard_LRS"
    }
    
}


###########Azure cache for redis#########

  redis-name = "redis-cus-dev"
  redis-capacity = 2
  redis-tier = "C"
  redis-sku_name = "Standard"
  non_ssl_port_enabled = "false"
  minimum_tls_version = "1.2"