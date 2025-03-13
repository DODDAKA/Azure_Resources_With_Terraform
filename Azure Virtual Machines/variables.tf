variable "rg_name" {
  description = "vm rg"
  type = string
}

variable "rg_location" {
  type = string
  description = "rg location"
}

variable "vnet_hub" {
  description = "this is VNET and SNET details"
  type = map(object({
    address_space = list(string)
    subnets=map(object({                          ### map(obj(map(obj))) difficult data type usage flated for loop have to use.
      snet_name = string
      snet_range = list(string)
    }))
  }))
}

variable "vms_hub" {
  description = "These are hub vms"
  type = map(object({
      size = string
      admin_username      = string
      storage_account_type = string
  }))
}