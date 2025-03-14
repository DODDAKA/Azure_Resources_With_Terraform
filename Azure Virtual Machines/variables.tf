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


########################## Azure cache for Redis ######################

variable "redis-name" {
  description = "redis-name"
  type = string
}

variable "redis-capacity" {
  description = "redis-capacity"
  type = string
}

variable "redis-tier" {
  description = "redis-tier"
  type = string
}

variable "redis-sku_name" {
  description = "redis-skuname"
  type = string
}

variable "non_ssl_port_enabled" {
  description = "non-ssl-port-enabled"
  type = string
}

variable "minimum_tls_version" {
  description = "minimum-tls0"
  type = string
}


