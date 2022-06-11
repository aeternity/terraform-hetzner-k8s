output "network_name" {
  value = resource.hcloud_network.main.*.name
}

output "network_ip_range" {
  value = resource.hcloud_network.main.*.ip_range
}

output "network_id" {
  value = resource.hcloud_network.main.*.id
}

output "subnet_id" {
  value = resource.hcloud_network_subnet.main.*.id
}

output "subnet_ip_range" {
  value = resource.hcloud_network_subnet.main.*.ip_range
}
