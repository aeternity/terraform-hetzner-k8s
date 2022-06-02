output "dns_zone_id" {
  value = resource.hetznerdns_zone.main.*.id
}
