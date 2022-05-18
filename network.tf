module "network" {
  source              = "./modules/tf_hertzner_network"
  network_ip_range    = local.config.network_ip_range
  network_name        = "${local.env}-network"
  subnet_type         = local.config.subnet_type
  subnet_network_zone = local.config.subnet_network_zone
  subnet_ip_ranges    = local.config.subnet_ip_ranges
}
