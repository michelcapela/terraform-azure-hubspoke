variable "location" {
  default = "westeurope"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "test"
    owner       = "michel.capela"
    project     = "lua-enterprise"
    cost_center = "lua-cloud"
  }
}


variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

