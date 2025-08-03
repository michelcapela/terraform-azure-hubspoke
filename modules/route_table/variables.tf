variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}


variable "resource_group_name" {
  type = string
}

variable "destination_prefix" {
  type = string
}

variable "next_hop_ip" {
  type = string
}

variable "tags" {
  type = map(string)
}