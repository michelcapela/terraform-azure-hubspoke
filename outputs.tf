output "firewall_private_ip" {
  value = module.firewall.private_ip
}

output "function_app_id" {
  value = module.function_app.function_app_id
}

output "private_endpoint_id" {
  value = module.private_endpoint.id
}

output "nsg_a_id" {
  value = module.nsg_a.id
}

output "nsg_b_id" {
  value = module.nsg_b.id
}

output "nsg_c_id" {
  value = module.nsg_c.id
}

output "peering_a_spoke_to_hub_id" {
  value = module.peering_a.spoke_to_hub_id
}

output "peering_a_hub_to_spoke_id" {
  value = module.peering_a.hub_to_spoke_id
}

output "peering_b_spoke_to_hub_id" {
  value = module.peering_b.spoke_to_hub_id
}

output "peering_b_hub_to_spoke_id" {
  value = module.peering_b.hub_to_spoke_id
}

output "peering_c_spoke_to_hub_id" {
  value = module.peering_c.spoke_to_hub_id
}

output "peering_c_hub_to_spoke_id" {
  value = module.peering_c.hub_to_spoke_id
}

output "rg_network_name" {
  value = module.rg_network.name
}

output "rg_workload_name" {
  value = module.rg_workload.name
}

output "route_table_a_id" {
  value = module.udr_a.id
}

output "route_table_b_id" {
  value = module.udr_b.id
}

output "subnet_a_id" {
  value = module.subnet_a.id
}

output "subnet_b_id" {
  value = module.subnet_b.id
}

output "subnet_c_id" {
  value = module.subnet_c.id
}

output "subnet_fw_id" {
  value = module.subnet_firewall.id
}

output "vm_a_private_ip" {
  value = module.vm_linux_a.private_ip
}

output "vm_b_private_ip" {
  value = module.vm_linux_b.private_ip
}

output "vnet_a_id" {
  value = module.vnet_a.id
}

output "vnet_b_id" {
  value = module.vnet_b.id
}

output "vnet_c_id" {
  value = module.vnet_c.id
}

output "vnet_fw_id" {
  value = module.vnet_firewall.id
}
