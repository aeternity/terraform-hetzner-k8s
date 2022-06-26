module "bastion-node" {
  source          = "./modules/tf_hetzner_servers"
  network_id      = module.network.network_id[0]
  instance_count  = local.common_instance_count
  name            = "bastion-${local.env}"
  server_type     = local.common_server_type
  labels          = local.standard_tags
  image           = local.common_image
  disk_format     = local.common_disk_format
  disk_size       = local.common_disk_size
  ssh_keys        = local.common_ssh_keys
  attach_firewall = true
  #cidr_prefix = module.network.subnet_ip_range
  subnet_ids = module.network.subnet_id
  firewall_rules = [
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
    },
  ]
  #attach_dns = true
  #dns_record = {
    #dns_name        = "bastion"
    #dns_domain      = "superhero.io"
    #dns_record_type = "A"
    #dns_ttl         = "300"
    #dns_zone_id     = module.superhero-io-dns-zone.dns_zone_id[0]
  #}
}
