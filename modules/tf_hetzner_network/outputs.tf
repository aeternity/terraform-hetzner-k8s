output "network_name" {
  value = resource.hcloud_network.main.name
}

output "network_ip_range" {
  value = resource.hcloud_network.main.ip_range
}

output "network_id" {
  value = resource.hcloud_network.main.id
}

output "private_subnet_id" {
  value = resource.hcloud_network_subnet.private.id
}

output "public_subnet_id" {
  value = resource.hcloud_network_subnet.public.id
}

output "private_subnet_ip_range" {
  value = resource.hcloud_network_subnet.private.ip_range
}

output "public_subnet_ip_range" {
  value = resource.hcloud_network_subnet.public.ip_range
}
