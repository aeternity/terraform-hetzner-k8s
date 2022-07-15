variable "server_type" {
  default = "cx11"
  type    = string
}
variable "image" {
  default = "ubuntu-20.04"
  type    = string
}
variable "location" {
  default = "nbg1"
  type    = string
}
variable "ssh_keys" {
  default = []
  type    = list(string)
}

variable "firewall_ids" {
  default = []
  type    = list(string)
}

variable "delete_protection" {
  default = false
  type    = string
}

variable "network_id" {
  default = null
  type    = string
}

variable "ip" {
  default = null
  type    = string
}

variable "alias_ips" {
  default = []
  type    = list(string)
}

variable "disk_size" {
  default = "10"
  type    = string
}

variable "disk_format" {
  default = "ext4"
  type    = string
}

variable "name" {
  default = null
  type    = string
}

variable "instance_count" {
  default = "1"
  type    = string
}

variable "floating_ip" {
  default = false
  type    = bool
}

variable "hcloud_placement_group" {
  default = true
  type    = bool
}

variable "labels" {
  default = {}
  type    = map(string)
}

variable "attached_disk" {
  default = false
  type    = bool
}

variable "attach_firewall" {
  default = true
  type    = bool
}

variable "attach_dns" {
  default = false
  type    = bool
}

variable "firewall_rules" {
  type = list(object({
    direction       = string
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string))
    description     = optional(string)
  }))
  default     = []
  description = "Configuration of a Rule from this Firewall"
}

variable "dns_record" {
  description = "Everything for a dns record."
  default     = null
  type = object({
    dns_name        = any,
    dns_domain      = any,
    dns_zone_id     = any,
    dns_record_type = any,
    dns_ttl         = any
  })
}

variable "cidr_prefix" {
  default = null
}

variable "subnet_ids" {
  type = any
  #default = []
}

variable "attach_to_lb" {
  default = false
  type    = bool
}

variable "load_balancer_id" {
  type = any
  default = null
}

variable "lb_target_type" {
  type = string
  default = "server"
}
