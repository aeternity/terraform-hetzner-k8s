module "k8s-master-nodes" {
  source     = "./modules/tf_hertzner_servers"
  network_id = module.network.network_id[0]
  #network_id     = data.terraform_remote_state.network.outputs.network_id[0]
  instance_count = local.config.k8s_master_instance_count
  name           = "${local.env}-k8s-master-node"
  server_type    = local.config.k8s_master_server_type
  labels         = local.standard_tags
  image          = local.config.k8s_master_image
  disk_format    = local.config.k8s_master_disk_format
  disk_size      = local.config.k8s_master_disk_size
  ssh_keys       = local.config.k8s_master_ssh_keys
}
