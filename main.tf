#--------- firewall nat rule collection ------------
resource "azurerm_firewall_network_rule_collection" "azure_firewall_network_rule_collection" {
  for_each            = local.azure_firewall_network_rule_collection
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  azure_firewall_name = each.value.azure_firewall_name
  priority            = each.value.priority
  action              = each.value.action == "Allow" ? "Deny" : "Allow"

  dynamic "rule" {
    for_each = each.value.rule_list
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}


