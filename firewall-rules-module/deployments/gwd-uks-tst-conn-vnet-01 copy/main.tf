terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.30.0"
    }
  }
  required_version = ">= 1.3.3"
}

module "network-firewall-rules" {
  source = "C:/Users/ben/git/terraform/modules/testing/network-firewall-rules"

  firewall_policy_rule_collection_group_name   = "thisisatest"
  firewall_policy_rule_collection_group_policy = 3789

  network_rule_collections = [
    {
      name     = "this-is-a-net-test"
      priority = 3750
      action   = "Allow"
      rules = [
        {
          name                  = "test net 1"
          protocols             = ["TCP"]
          source_addresses      = var.address_space
          source_ip_groups      = null
          destination_addresses = null
          destination_ip_groups = [
            data.azurerm_ip_group.onprem_dns_servers.id,
            data.azurerm_ip_group.az_dns_servers.id
          ]
          destination_fqdns = null
          destination_ports = ["53"]
        },
        {
          name                  = "test net 2"
          protocols             = ["TCP"]
          source_addresses      = var.address_space
          source_ip_groups      = null
          destination_addresses = null
          destination_ip_groups = [data.azurerm_ip_group.onprem_sccmservers.id]
          destination_fqdns     = null
          destination_ports     = ["80", "443", "445", "8005", "8530", "8531", "10123"]
        }
      ]
    }
  ]

  application_rule_collections = [
    {
      name     = "this-is-an-application-test"
      priority = 3500
      action   = "Allow"
      rules = [
        {
          name = "test app 1"
          protocols = [
            {
              type = "Http"
              port = 80
            },
            {
              type = "Https"
              port = 443
            }
          ]
          source_addresses      = var.address_space
          source_ip_groups      = null
          destination_addresses = ["*"]
          destination_urls = null
          destination_fqdns = null
          destination_fqdns_tags     = null
        },
        {
          name = "test app 2"
          protocols = [
            {
              type = "Https"
              port = 443
            }
          ]
          source_addresses      = var.address_space
          source_ip_groups      = null
          destination_addresses = null
          destination_urls = null
          destination_fqdns = null
          destination_fqdns_tags     = ["HDInsight"]
        },
        {
          name = "test app 3"
          protocols = [
            {
              type = "Https"
              port = 443
            }
          ]
          source_addresses      = var.address_space
          source_ip_groups      = null
          destination_addresses = null
          destination_urls = null
          destination_fqdns = [
            "psg-prod-eastus.azureedge.net,az818661.vo.msecnd.net",
            "psg-prod-centralus.azureedge.net,onegetcdn.azureedge.net",
            "*.powershellgallery.com,go.microsoft.com",
            "devopsgallerystorage.blob.core.windows.net"
          ]
          destination_fqdns_tags     = null
        }
      ]
    }
  ]
}