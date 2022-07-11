module "pg-backend-node" {
  source          = "./modules/tf_hetzner_servers"
  network_id      = module.network.network_id[0]
  instance_count  = local.config.common_instance_count
  name            = "pg-backend-${local.env}"
  server_type     = local.config.common_server_type
  labels          = local.standard_tags
  image           = local.config.common_image
  disk_format     = local.config.common_disk_format
  disk_size       = local.config.common_disk_size
  ssh_keys        = local.config.common_ssh_keys
  attach_firewall = true
  cidr_prefix = module.network.subnet_ip_range
  subnet_ids = module.network.subnet_id
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
  ]
}
