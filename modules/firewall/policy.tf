resource "azurerm_firewall_policy" "this" {
  name                = "${var.name}-policy"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_firewall_policy_rule_collection_group" "this" {
  name               = "${var.name}-rule-group"
  firewall_policy_id = azurerm_firewall_policy.this.id
  priority           = 100

  //Essa regra não faz efeito já que a conexão é feita diretamente pelo Private Endpoint
  //  application_rule_collection {
  //    name     = "Allow-HTTPS-To-Function"
  //    priority = 100
  //   action   = "Allow"
  //   rule {
  //     name              = "Allow-FunctionApp-HTTPS"
  //     source_addresses  = ["10.2.0.0/24"]
  //     destination_fqdns = ["lua-function-app.azurewebsites.net"]
  //     protocols {
  //       port = 443
  //       type = "Https"
  //     }
  //   }
  // }

  network_rule_collection {
    name     = "Allow-ICMP"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "Allow-ICMP-A-B"
      protocols             = ["ICMP"]
      source_addresses      = ["10.1.0.0/24"]
      destination_addresses = ["10.2.0.0/24"]
      destination_ports     = ["*"]
    }
  }
}
