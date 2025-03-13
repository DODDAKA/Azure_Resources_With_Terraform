# resource "azurerm_virtual_machine_extension" "enable_winrm" {
#     provider = azurerm.dev_env
#   name                 = "enable-winrm"
#   virtual_machine_id   = azurerm_windows_virtual_machine.example["vm-win-cus-hub"].id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"

#   settings = <<SETTINGS
#     {
#       "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"Enable-PSRemoting -Force; Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any\""
#     }
#   SETTINGS
# }


# resource "null_resource" "setup_script" {
#   depends_on = [azurerm_windows_virtual_machine.example]

#   # File provisioner: Copy the script to the remote VM
#   provisioner "file" {
#     source      = "C:/Users/Msr/Desktop/Azure_Resources_With_Terraform/Azure Virtual Machines/script.ps1" # Adjust path as needed
#     destination = "C:\\script.ps1"

#     connection {
#       type        = "winrm"
#       user        = "adminuser" #azurerm_linux_virtual_machine.hubcusjumphost.admin_username
#       password    = "Naveenkumar@123" #azurerm_linux_virtual_machine.hubcusjumphost.admin_password
#       host        = azurerm_public_ip.vmpip.ip_address
#       timeout     = "10m"
#     }
#   }

#   # Remote exec provisioner: Execute the copied script
#   provisioner "remote-exec" {
#     inline = [
#       "powershell -ExecutionPolicy Bypass -File C:\\script.ps1"
#     ]
#     connection {
#       type        = "winrm"
#       user        = "adminuser" #azurerm_linux_virtual_machine.hubcusjumphost.admin_username
#       password    = "Naveenkumar@123" #azurerm_linux_virtual_machine.hubcusjumphost.admin_password
#       host        = azurerm_public_ip.vmpip.ip_address
#       timeout     = "10m"
#     }
#   }
# }












##################################
//Below one is working fine
###################################

resource "null_resource" "setup_script" {
  # Copy the script to the VM using an RDP session
  provisioner "local-exec" {
    command = <<EOT
      cmdkey /generic:${azurerm_public_ip.vmpip.ip_address} /user:adminuser /pass:Naveenkumar@123
      mstsc /v:${azurerm_public_ip.vmpip.ip_address}
    EOT
  }

  # Execute the script on the VM using an RDP session
  provisioner "local-exec" {
    command = <<EOT
      powershell -Command "Copy-Item -Path 'C:/Users/Msr/Desktop/Azure_Resources_With_Terraform/Azure Virtual Machines/script.ps1' -Destination 'C:\\script.ps1' -ToSession (New-PSSession -ComputerName ${azurerm_public_ip.vmpip.ip_address} -Credential (Get-Credential))"
      powershell -Command "Invoke-Command -ComputerName ${azurerm_public_ip.vmpip.ip_address} -Credential (Get-Credential) -ScriptBlock { powershell -ExecutionPolicy Bypass -File C:\\script.ps1 }"
    EOT
  }
}


##################