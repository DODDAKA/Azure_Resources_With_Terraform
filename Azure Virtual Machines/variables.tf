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
    subnets=map(object({
      snet_name = string
      snet_range = list(string)
    }))
  }))
}