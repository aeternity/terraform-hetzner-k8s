module "ohmyform-node" {
  source          = "./modules/tf_hetzner_servers"
  network_id      = module.network.network_id
  instance_count  = local.config.ohmyform_instance_count
  name            = "ohmyform-${local.env}"
  server_type     = local.config.common_server_type
  labels          = local.standard_tags
  image           = local.config.common_image
  disk_format     = local.config.common_disk_format
  disk_size       = local.config.common_disk_size
  ssh_keys        = local.config.ssh_keys
  attach_firewall = true
  attached_disk   = true
  subnet_ids      = module.network.private_subnet_id
  internal_dns_record = false
  attach_dns      = true
  dns_record = {
    dns_name        = "ohmyform.${local.env_human}.service"
    dns_record_type = "A"
    dns_ttl         = "300"
    dns_zone_id     = data.aws_route53_zone.aepps.id
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
      port       = "443"
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
