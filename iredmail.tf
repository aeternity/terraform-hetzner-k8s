module "iredmail-node" {
  source              = "./modules/tf_hetzner_servers"
  network_id          = module.network.network_id
  instance_count      = local.config.iredmail_instance_count
  name                = "iredmail-${local.env}"
  server_type         = local.config.common_server_type
  labels              = local.standard_tags
  image               = local.config.common_image
  disk_format         = local.config.common_disk_format
  disk_size           = local.config.iredmail_disk_size
  ssh_keys            = local.config.ssh_keys
  attach_firewall     = true
  attached_disk       = true
  subnet_ids          = module.network.private_subnet_id
  internal_dns_record = false
  attach_dns          = true
  dns_record = {
    dns_name        = "iredmail.${local.env_human}.service"
    dns_record_type = "A"
    dns_ttl         = "300"
    dns_zone_id     = data.aws_route53_zone.aepps.id
  }

  firewall_rules = [
    # Inbound rules
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "25"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "443"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "80"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "110"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "143"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "465"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "587"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "993"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "995"
      source_ips = ["0.0.0.0/0", "::/0"]
    },

    # Outbound rules
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
    }
  ]
}
