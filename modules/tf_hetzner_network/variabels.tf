variable "network_name" {
  description = "The name of the network being created"
  default = null
  type        = string
}

variable "network_ip_range" {
  description = "The range of the network being created"
  type        = string
}

variable "private_subnet_ip_ranges" {
  description = "The subnet ip ranges"
  type = string
}

variable "public_subnet_ip_ranges" {
  description = "The subnet ip ranges"
  type = string
}

variable "subnet_network_zone" {
  description = "The subnet zone"
  default     = "eu-central"
  type        = string
}

variable "subnet_type" {
  description = "The subnet zone"
  default     = "cloud"
  type        = string
}

variable "create_network" {
  description = "To create hcloud network or not - boolean"
  default     = "true"
  type        = bool
}
