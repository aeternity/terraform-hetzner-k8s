terraform {
  required_providers {
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }
}

resource "hetznerdns_zone" "main" {
  count = var.create_dns_zone ? 1 : 0
  name  = var.domain_name
  ttl   = 3600
}

resource "hetznerdns_record" "main" {
  for_each = var.dns_records
  zone_id  = lookup(each.value, "zone_id")
  value    = lookup(each.value, "value")
  type     = lookup(each.value, "type")
  ttl      = lookup(each.value, "ttl", 300)
  name     = lookup(each.value, "name")
}
