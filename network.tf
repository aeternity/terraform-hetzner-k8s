module "network" {
  source              = "./modules/tf_hetzner_network"
  network_ip_range    = local.config.network_ip_range
  network_name        = "${local.env}-network"
  subnet_type         = local.config.subnet_type
  subnet_network_zone = local.config.subnet_network_zone
  private_subnet_ip_ranges    = local.config.private_subnet_ip_ranges
  public_subnet_ip_ranges    = local.config.public_subnet_ip_ranges
}
