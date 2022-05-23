module "pg-backend-node" {
  source         = "./modules/tf_hertzner_servers"
  network_id     = module.network.network_id[0]
  instance_count = local.config.pg_backend_instance_count
  name           = "pg-backend-${local.env}"
  server_type    = local.config.pg_backend_server_type
  labels         = local.standard_tags
  image          = local.config.pg_backend_image
  disk_format    = local.config.pg_backend_disk_format
  disk_size      = local.config.pg_backend_disk_size
  ssh_keys       = local.config.pg_backend_ssh_keys
}
