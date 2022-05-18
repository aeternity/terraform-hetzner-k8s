module "k8s-master-nodes" {
  source         = "./modules/tf_hertzner_servers"
  network_id     = module.network.network_id[0]
  instance_count = local.config.master_instance_count
  name           = "${local.env}-k8s-master-node"
  server_type    = local.config.server_type
  labels         = local.standard_tags
  image          = local.config.image
  disk_format    = local.config.disk_format
  disk_size      = local.config.disk_size
  ssh_keys       = local.config.ssh_keys
}
