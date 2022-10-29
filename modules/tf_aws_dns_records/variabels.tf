variable "dns_records" {
  description = "List of maps with type, rrdatas and optional ttl for static zone records."
  type        = any
  default     = {}
}
