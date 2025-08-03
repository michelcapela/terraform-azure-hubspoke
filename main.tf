module "rg_network" {
  source   = "./modules/resource_group"
  name     = "rg-network"
  location = var.location
  tags     = var.tags
}

module "rg_workload" {
  source   = "./modules/resource_group"
  name     = "rg-workload"
  location = var.location
  tags     = var.tags
}

module "vnet_firewall" {
  source              = "./modules/vnet"
  name                = "lua-vnet-fw"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = module.rg_network.name
  depends_on          = [module.rg_network]
  tags                = var.tags
}

module "vnet_a" {
  source              = "./modules/vnet"
  name                = "lua-vnet-a"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = module.rg_network.name
  depends_on          = [module.rg_network]
  tags                = var.tags
}

module "vnet_b" {
  source              = "./modules/vnet"
  name                = "lua-vnet-b"
  address_space       = ["10.2.0.0/16"]
  location            = var.location
  resource_group_name = module.rg_network.name
  depends_on          = [module.rg_network]
  tags                = var.tags
}

module "vnet_c" {
  source              = "./modules/vnet"
  name                = "lua-vnet-c"
  address_space       = ["10.3.0.0/16"]
  location            = var.location
  resource_group_name = module.rg_network.name
  depends_on          = [module.rg_network]
  tags                = var.tags
}

module "subnet_firewall" {
  source               = "./modules/subnet"
  name                 = "AzureFirewallSubnet"
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet_firewall.name
  address_prefixes     = ["10.0.0.0/26"]
  depends_on           = [module.vnet_firewall]
  tags                 = var.tags
}

module "subnet_a" {
  source               = "./modules/subnet"
  name                 = "subnet-a"
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet_a.name
  address_prefixes     = ["10.1.0.0/24"]
  depends_on           = [module.vnet_a]
  tags                 = var.tags
}

module "subnet_b" {
  source               = "./modules/subnet"
  name                 = "subnet-b"
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet_b.name
  address_prefixes     = ["10.2.0.0/24"]
  depends_on           = [module.vnet_b]
  tags                 = var.tags
}

module "subnet_c" {
  source               = "./modules/subnet"
  name                 = "subnet-c"
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet_c.name
  address_prefixes     = ["10.3.0.0/24"]
  depends_on           = [module.vnet_c]
  tags                 = var.tags
}

module "firewall" {
  source              = "./modules/firewall"
  name                = "lua-fw"
  location            = var.location
  resource_group_name = module.rg_network.name
  subnet_id           = module.subnet_firewall.id
  pip_name            = "lua-pip-fw"
  depends_on          = [module.subnet_firewall]
  tags                = var.tags
}

module "peering_a" {
  source              = "./modules/peering"
  resource_group_name = module.rg_network.name
  spoke_name          = module.vnet_a.name
  hub_name            = module.vnet_firewall.name
  spoke_id            = module.vnet_a.id
  hub_id              = module.vnet_firewall.id
  name_spoke_to_hub   = "spoke-a-to-hub"
  name_hub_to_spoke   = "hub-to-spoke-a"
  depends_on          = [module.vnet_a, module.vnet_firewall]
  tags                = var.tags
}

module "peering_b" {
  source              = "./modules/peering"
  resource_group_name = module.rg_network.name
  spoke_name          = module.vnet_b.name
  hub_name            = module.vnet_firewall.name
  spoke_id            = module.vnet_b.id
  hub_id              = module.vnet_firewall.id
  name_spoke_to_hub   = "spoke-b-to-hub"
  name_hub_to_spoke   = "hub-to-spoke-b"
  depends_on          = [module.vnet_b, module.vnet_firewall]
  tags                = var.tags
}

module "peering_c" {
  source              = "./modules/peering"
  resource_group_name = module.rg_network.name
  spoke_name          = module.vnet_c.name
  hub_name            = module.vnet_firewall.name
  spoke_id            = module.vnet_c.id
  hub_id              = module.vnet_firewall.id
  name_spoke_to_hub   = "spoke-c-to-hub"
  name_hub_to_spoke   = "hub-to-spoke-c"
  depends_on          = [module.vnet_c, module.vnet_firewall]
  tags                = var.tags
}

module "nsg_a" {
  source              = "./modules/nsg"
  name                = "nsg-subnet-a"
  location            = var.location
  resource_group_name = module.rg_network.name
  subnet_id           = module.subnet_a.id
  enable_icmp         = true
  depends_on          = [module.subnet_a]
  tags                = var.tags
}

module "nsg_b" {
  source              = "./modules/nsg"
  name                = "nsg-subnet-b"
  location            = var.location
  resource_group_name = module.rg_network.name
  subnet_id           = module.subnet_b.id
  enable_icmp         = true
  depends_on          = [module.subnet_b]
  tags                = var.tags
}

module "nsg_c" {
  source              = "./modules/nsg"
  name                = "nsg-subnet-c"
  location            = var.location
  resource_group_name = module.rg_network.name
  subnet_id           = module.subnet_c.id
  enable_icmp         = false
  depends_on          = [module.subnet_c]
  tags                = var.tags
}



module "udr_a" {
  source              = "./modules/route_table"
  name                = "udr-subnet-a"
  location            = var.location
  resource_group_name = module.rg_network.name
  destination_prefix  = "0.0.0.0/0"
  next_hop_ip         = module.firewall.private_ip
  subnet_id           = module.subnet_a.id
  depends_on          = [module.firewall]
  tags                = var.tags
}


module "udr_b" {
  source              = "./modules/route_table"
  name                = "udr-subnet-b"
  location            = var.location
  resource_group_name = module.rg_network.name
  destination_prefix  = "0.0.0.0/0"
  next_hop_ip         = module.firewall.private_ip
  subnet_id           = module.subnet_b.id
  depends_on          = [module.firewall]
  tags                = var.tags
}

//udr_c não faz sentido para o Firewall pois usamos o Private Endpoint
//Vou deixar aqui para forçar padrão via firewall em futuras mudanças
module "udr_c" {
  source              = "./modules/route_table"
  name                = "udr-subnet-c"
  location            = var.location
  resource_group_name = module.rg_network.name
  destination_prefix  = "0.0.0.0/0"
  next_hop_ip         = module.firewall.private_ip
  subnet_id           = module.subnet_c.id
  depends_on          = [module.firewall]
  tags                = var.tags
}


module "vm_linux_a" {
  source              = "./modules/vm"
  vm_name             = "vm-linux-a"
  nic_name            = "nic-vm-linux-a"
  location            = var.location
  resource_group_name = module.rg_workload.name
  subnet_id           = module.subnet_a.id
  size                = "Standard_B1ms"
  admin_username      = "azureuser"
  admin_password      = var.admin_password
  depends_on          = [module.nsg_a, module.udr_a]
  tags                = var.tags
}

module "vm_linux_b" {
  source              = "./modules/vm"
  vm_name             = "vm-linux-b"
  nic_name            = "nic-vm-linux-b"
  location            = var.location
  resource_group_name = module.rg_workload.name
  subnet_id           = module.subnet_b.id
  size                = "Standard_B1ms"
  admin_username      = "azureuser"
  admin_password      = var.admin_password
  depends_on          = [module.nsg_b, module.udr_b]
  tags                = var.tags
}

module "function_app" {
  source                = "./modules/function_app"
  storage_account_name  = "luafuncstorage"
  resource_group_name   = module.rg_workload.name
  location              = var.location
  app_service_plan_name = "lua-func-plan"
  function_app_name     = "lua-function-app"
  depends_on            = [module.nsg_c]
  tags                  = var.tags
}

module "private_endpoint" {
  source              = "./modules/private_endpoint"
  name                = "lua-private-endpoint"
  location            = var.location
  resource_group_name = module.rg_network.name
  subnet_id           = module.subnet_c.id
  connection_name     = "pe-func-to-vm-b"
  resource_id         = module.function_app.function_app_id
  subresource_name    = "sites"
  depends_on          = [module.vm_linux_b, module.function_app]
  tags                = var.tags
}

