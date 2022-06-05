output "subnet_ip_range" {
  value = module.network.subnet_ip_range
}

output "network_ip_range" {
  value = module.network.network_ip_range
}

output "network_id" {
  value = module.network.network_id
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "bastion_server_id" {
  value = module.bastion-node.server_id
}

output "master_nodes_ips" {
  value = module.k8s-master-nodes.servers_ips
}
