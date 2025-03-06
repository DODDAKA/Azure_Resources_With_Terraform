rg_name = "rg-hub"
rg_location = "centralus"
vnet_hub = {
  virtual_network1 = {
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
            snet_name = "snet-hub-acr-01-cus"
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