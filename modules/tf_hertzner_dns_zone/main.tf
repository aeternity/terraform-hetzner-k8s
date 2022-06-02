terraform {
  required_providers {
    hetznerdns = {
      source = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }
}

resource "hetznerdns_zone" "main" {
  count = var.create_dns_zone ? 1 : 0
  name  = var.domain_name
  ttl   = 3600
}
