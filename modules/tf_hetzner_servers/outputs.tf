output "hcloud_floating_ip" {
  value = resource.hcloud_floating_ip.main.*.ip_address
}

output "hcloud_floating_ip_id" {
  value = resource.hcloud_floating_ip.main.*.id
}

output "server_id" {
  value = resource.hcloud_server.main.*.id
}

output "firewall_id" {
  value = resource.hcloud_firewall.main.*.id
}

output "servers_public_ips" {
  value = resource.hcloud_server.main.*.ipv4_address
}

output "servers_internal_ips" {
  value = resource.hcloud_server_network.main.*.ip
}
