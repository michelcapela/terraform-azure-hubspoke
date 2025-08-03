variable "resource_group_name" {
  type = string
}

variable "spoke_name" {
  type = string
}

variable "hub_name" {
  type = string
}

variable "spoke_id" {
  type = string
}

variable "hub_id" {
  type = string
}

variable "name_spoke_to_hub" {
  type = string
}

variable "name_hub_to_spoke" {
  type = string
}

variable "tags" {
  type = map(string)
}