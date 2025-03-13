resource "azurerm_public_ip" "vmpip" {
  provider = azurerm.dev_env
  name                = "vmpip"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "example" {
    provider = azurerm.dev_env
    for_each = var.vms_hub
  name                = each.key
  location            = azurerm_resource_group.rg-hub.location
  resource_group_name = azurerm_resource_group.rg-hub.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet_hub_mgmt_01_cus.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vmpip.id
  }
  depends_on = [ azurerm_subnet.snets ]
}

resource "azurerm_linux_virtual_machine" "example" {
    provider = azurerm.dev_env
    for_each = var.vms_hub
  name                = each.key
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  disable_password_authentication=false
  network_interface_ids = [
    azurerm_network_interface.example[each.key].id,
  ]
  
    admin_password = "Naveenkumar@123"
    ### Not needed disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # source_image_reference {
  #   publisher = "MicrosoftWindowsServer"
  #   offer     = "WindowsServer"
  #   sku       = "2019-Datacenter"
  #   version   = "latest"
    
  # }

source_image_reference {
  publisher = "RedHat"
  offer     = "RHEL"
  sku       = "7.6"
  version   = "latest"
}

}