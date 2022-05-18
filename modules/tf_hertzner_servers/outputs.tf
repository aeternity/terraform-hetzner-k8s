output "hcloud_floating_ip" {
  value = resource.hcloud_floating_ip.main.*.ip_address
}

output "hcloud_floating_ip_id" {
  value = resource.hcloud_floating_ip.main.*.id
}
