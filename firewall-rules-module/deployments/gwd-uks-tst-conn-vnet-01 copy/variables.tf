variable "source_name" {
  type    = string
  default = "gwd-uks-tst-conn-vnet-01"
}

variable "address_space" {
  type    = list(string)
  default = ["172.12.0.0/24"]
}

variable "ip_group_resource_group" {
  type    = string
  default = "gwd-uks-conn-fw-rg-01"
}