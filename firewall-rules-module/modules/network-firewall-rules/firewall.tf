resource "azurerm_firewall_policy_rule_collection_group" "firewall_collection_group" {

  name               = var.firewall_policy_rule_collection_group_name
  firewall_policy_id = data.azurerm_firewall_policy.firewall_policy.id
  priority           = var.firewall_policy_rule_collection_group_policy

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collections != null ? var.network_rule_collections : []
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = can(network_rule_collection.value.rules) ? network_rule_collection.value.rules : []

        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          destination_addresses = rule.value.destination_addresses
          destination_ip_groups = rule.value.destination_ip_groups
          destination_fqdns     = rule.value.destination_fqdns
          destination_ports     = rule.value.destination_ports

        }
      }
    }
  }

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collections != null ? var.application_rule_collections : []
    content {
      name     = application_rule_collections.value.name
      priority = application_rule_collections.value.priority
      action   = application_rule_collections.value.action

      dynamic "rule" {
        for_each = can(application_rule_collections.value.rules) ? application_rule_collections.value.rules : []

        content {
          name = rule.value.name
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
          source_addresses      = rule.value.source_addresses
          destination_addresses = rule.value.destination_addresses
          destination_ports     = rule.value.destination_ports
        }
      }
    }
  }
}