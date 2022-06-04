module "k8s-worker-nodes" {
  source         = "./modules/tf_hertzner_servers"
  network_id     = module.network.network_id[0]
  instance_count = local.config.k8s_worker_instance_count
  name           = "${local.env}-k8s-worker-node"
  server_type    = local.config.k8s_worker_server_type
  labels         = local.standard_tags
  image          = local.config.k8s_worker_image
  disk_format    = local.config.k8s_worker_disk_format
  disk_size      = local.config.k8s_worker_disk_size
  ssh_keys       = local.config.k8s_worker_ssh_keys
}
