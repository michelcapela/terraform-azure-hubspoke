variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "enable_icmp" {
  description = "Enable ICMP allow rules"
  type        = bool
  default     = false
}
