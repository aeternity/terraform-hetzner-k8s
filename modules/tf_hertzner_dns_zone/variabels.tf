variable "domain_name" {
  type = string
}

variable "create_dns_zone" {
  type    = bool
  default = false
}

variable "dns_records" {
  description = "List of maps with type, rrdatas and optional ttl for static zone records."
  type        = any
  default     = {}
}
