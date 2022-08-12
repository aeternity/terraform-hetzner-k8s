output "network_ip_range" {
  value = module.network.network_ip_range
}

output "network_id" {
  value = module.network.network_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "bastion_server_id" {
  value = module.bastion-node.server_id
}

output "master_nodes_public_ips" {
  value = module.k8s-master-nodes.servers_public_ips
}
output "master_nodes_internal_ips" {
  value = module.k8s-master-nodes.servers_internal_ips
}

output "worker_nodes_public_ips" {
  value = module.k8s-worker-nodes.servers_public_ips
}

output "worker_nodes_internal_ips" {
  value = module.k8s-worker-nodes.servers_internal_ips
}

output "lb_control_plane_ip" {
  value = module.k8s-control-plane-lb.lb_ip
}

output "dns_zone_id" {
  value = local.create_dns_zone ? module.superk8s-de-dns-zone.dns_zone_id[0] : null
}

