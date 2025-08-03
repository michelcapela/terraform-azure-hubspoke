output "spoke_to_hub_id" {
  value = azurerm_virtual_network_peering.from_spoke_to_hub.id
}

output "hub_to_spoke_id" {
  value = azurerm_virtual_network_peering.from_hub_to_spoke.id
}
