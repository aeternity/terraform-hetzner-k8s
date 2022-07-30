module "pg-backend-node" {
  source          = "./modules/tf_hetzner_servers"
  network_id      = module.network.network_id
  instance_count  = local.config.common_instance_count
  name            = "pg-backend-${local.env}"
  server_type     = local.config.common_server_type
  labels          = local.standard_tags
  image           = local.config.common_image
  disk_format     = local.config.common_disk_format
  disk_size       = local.config.common_disk_size
  ssh_keys        = local.config.common_ssh_keys
  attach_firewall = true
  subnet_ids      = module.network.private_subnet_id
  attach_dns      = true
  dns_record = {
    dns_name        = "pg-backend"
    dns_domain      = "superk8s.de"
    dns_record_type = "A"
    dns_ttl         = "300"
    dns_zone_id     = module.superk8s-de-dns-zone.dns_zone_id[0]
  }
  firewall_rules = [
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction       = "out"
      protocol        = "tcp"
      port            = "53"
      destination_ips = ["0.0.0.0/0"]
    },
    {
      direction       = "out"
      protocol        = "udp"
      port            = "53"
      destination_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "5432"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction       = "out"
      protocol        = "tcp"
      port            = "any"
      destination_ips = ["0.0.0.0/0"]
    },
    {
      direction       = "out"
      protocol        = "udp"
      port            = "any"
      destination_ips = ["0.0.0.0/0"]
    },
  ]
}
