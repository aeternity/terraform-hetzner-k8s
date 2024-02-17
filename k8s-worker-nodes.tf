module "k8s-worker-nodes" {
  source         = "./modules/tf_hetzner_servers"
  network_id     = module.network.network_id
  instance_count = local.config.k8s_worker_instance_count
  name           = "${local.env}-k8s-worker-node"
  server_type    = local.config.k8s_worker_server_type
  labels         = local.standard_tags
  image          = local.config.k8s_worker_image
  disk_format    = local.config.k8s_worker_disk_format
  disk_size      = local.config.k8s_worker_disk_size
  ssh_keys       = local.config.k8s_worker_ssh_keys
  attached_disk   = false
  attach_firewall = true
  subnet_ids = module.network.private_subnet_id
  firewall_rules = [
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "any"
      source_ips = [module.network.network_ip_range]
    },
    {
      direction  = "in"
      protocol   = "udp"
      port       = "any"
      source_ips = [module.network.network_ip_range]
    },
    {
      direction  = "in"
      protocol   = "icmp"
      source_ips = [module.network.network_ip_range]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
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
    },
  ]
}
