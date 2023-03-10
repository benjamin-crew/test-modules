# Firewall Information

variable "firewall_policy_rule_collection_group_name" {
  description = "The name of the firewall policy rule collection group"
  type        = string
}

variable "firewall_resource_group_name" {
  type    = string
  default = "gwd-uks-conn-net-rg-01"
}

variable "firewall_policy_name" {
  type    = string
  default = "FirewallPolicy_gwduksconnfw01"
}

# Firewall Collection Information

variable "firewall_policy_rule_collection_group_policy" {
  type = number
}

variable "network_rule_collections" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      protocols             = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_ports     = optional(list(string))
    }))
  }))
}

variable "application_rule_collections" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name = string
      protocols = list(object({
        type = string
        port = number
      }))
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_urls      = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_fqdn_tags = optional(list(string))
    }))
  }))
}