module "superk8s-de-dns-zone" {
  source          = "./modules/tf_hetzner_dns_zone"
  domain_name     = "superk8s.de"
  create_dns_zone = local.create_dns_zone

  dns_records = {
     "@.SOA" = {
      value = "hydrogen.ns.hetzner.com. dns.hetzner.com. 2022073000 86400 10800 3600000 3600"
      type    = "SOA"
      name    = "@"
      zone_id = module.superk8s-de-dns-zone.dns_zone_id[0]
      ttl = "0"
    },
    "helium.ns.hetzner.de.NS" = {
      value = "helium.ns.hetzner.de."
      type    = "NS"
      name    = "@"
      zone_id = module.superk8s-de-dns-zone.dns_zone_id[0]
      ttl = "0"
    },
    "oxygen.ns.hetzner.com.NS" = {
      value = "oxygen.ns.hetzner.com."
      type    = "NS"
      name    = "@"
      zone_id = module.superk8s-de-dns-zone.dns_zone_id[0]
      ttl = "0"
    },
    "hydrogen.ns.hetzner.com.NS" = {
      value = "hydrogen.ns.hetzner.com."
      type    = "NS"
      name    = "@"
      zone_id = module.superk8s-de-dns-zone.dns_zone_id[0]
      ttl = "0"
    },
    "*.dev.A" = {
      value = "95.217.173.236"
      type    = "A"
      name    = "*.dev"
      zone_id = module.superk8s-de-dns-zone.dns_zone_id[0]
      ttl = "0"
    },
  }
}
