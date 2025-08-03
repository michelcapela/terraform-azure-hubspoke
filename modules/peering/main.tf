resource "azurerm_virtual_network_peering" "from_spoke_to_hub" {
  name                         = var.name_spoke_to_hub
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.spoke_name
  remote_virtual_network_id    = var.hub_id
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "from_hub_to_spoke" {
  name                         = var.name_hub_to_spoke
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.hub_name
  remote_virtual_network_id    = var.spoke_id
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}
