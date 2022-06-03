module "bastion-node" {
  source         = "./modules/tf_hertzner_servers"
  network_id     = module.network.network_id[0]
  instance_count = local.config.common_instance_count
  name           = "bastion-${local.env}"
  server_type    = local.config.common_server_type
  labels         = local.standard_tags
  image          = local.config.common_image
  disk_format    = local.config.common_disk_format
  disk_size      = local.config.common_disk_size
  ssh_keys       = local.config.common_ssh_keys
  attach_firewall = local.config.bastion_attach_firewall
  firewall_rules = local.config.bastion_firewall_rules
  attach_dns = local.config.bastion_attach_dns
  dns_record = local.config.bastion_dns_record
}
