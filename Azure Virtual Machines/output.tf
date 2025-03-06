output "snet_info" {
    description = "This is snet info"
  value = {for k,v in var.vnet_hub: k => v.subnets }
}