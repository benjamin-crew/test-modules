
data "azurerm_ip_group" "onprem_dns_servers" {
  name                = "grp_OnPremDNSServers"
  resource_group_name = var.ip_group_resource_group
}

data "azurerm_ip_group" "az_dns_servers" {
  name                = "grp_Az_DNSServers"
  resource_group_name = var.ip_group_resource_group
}

data "azurerm_ip_group" "onprem_domaincontrollers" {
  name                = "grp_gwdnt-OnPremiseDomainControllers"
  resource_group_name = var.ip_group_resource_group
}

data "azurerm_ip_group" "az_domaincontrollers" {
  name                = "grp_Az_DomainControllers"
  resource_group_name = var.ip_group_resource_group
}

data "azurerm_ip_group" "onprem_pkiissuingservers" {
  name                = "grp_OnPremPKIIssuingServers"
  resource_group_name = var.ip_group_resource_group
}

data "azurerm_ip_group" "onprem_sccmservers" {
  name                = "grp_OnPremSCCMServers"
  resource_group_name = var.ip_group_resource_group
}