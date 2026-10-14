# The stg cluster's pods reach the prd IPFS RPC API through its node public IPs.
data "terraform_remote_state" "stg" {
  count     = terraform.workspace == "prd" ? 1 : 0
  backend   = "pg"
  workspace = "stg"
  config    = {}
}

locals {
  ipfs_rpc_extra_sources = flatten([
    for s in data.terraform_remote_state.stg : [
      formatlist("%s/32", s.outputs.master_nodes_public_ips),
      formatlist("%s/32", s.outputs.worker_nodes_public_ips),
    ]
  ])
}

module "ipfs-node" {
  source              = "./modules/tf_hetzner_servers"
  network_id          = module.network.network_id
  instance_count      = local.config.ipfs_instance_count
  name                = "ipfs-${local.env}"
  server_type         = lookup(local.config, "ipfs_server_type", local.config.common_server_type)
  labels              = local.standard_tags
  image               = local.config.common_image
  disk_format         = local.config.common_disk_format
  disk_size           = lookup(local.config, "ipfs_disk_size", local.config.common_disk_size)
  ssh_keys            = local.config.common_ssh_keys
  attach_firewall     = true
  ipv6_any_in_rules   = true
  attached_disk       = true
  subnet_ids          = module.network.private_subnet_id
  internal_dns_record = false
  attach_dns          = true
  dns_record = {
    dns_name        = "ipfs.${local.env_human}.service"
    dns_record_type = "A"
    dns_ttl         = "300"
    dns_zone_id     = data.aws_route53_zone.aepps.id
  }
  firewall_rules = [
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "80"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "443"
      source_ips = ["0.0.0.0/0"]
    },
    {
      # public HTTP gateway - serves content, read-only, safe to expose
      direction  = "in"
      protocol   = "tcp"
      port       = "8080"
      source_ips = ["0.0.0.0/0"]
    },
    {
      # public P2P swarm - required for this node to participate in the IPFS network
      direction  = "in"
      protocol   = "tcp"
      port       = "4001"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "udp"
      port       = "4001"
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
      # RPC/admin API (add/pin/config) - never public. This hostname resolves to the
      # public IP (internal_dns_record = false), so consumers reach it via whichever
      # k8s node they're scheduled on, not the private network - restrict to the
      # private CIDR (future-proof) plus the k8s nodes' current public IPs (today's
      # actual egress path). Node IPs still change on node replacement; the durable
      # fix is switching consumers to a privately-resolving DNS record instead.
      direction  = "in"
      protocol   = "tcp"
      port       = "5000-5002"
      source_ips = concat(
        [module.network.network_ip_range],
        formatlist("%s/32", module.k8s-master-nodes.servers_public_ips),
        formatlist("%s/32", module.k8s-worker-nodes.servers_public_ips),
        local.ipfs_rpc_extra_sources,
      )
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
