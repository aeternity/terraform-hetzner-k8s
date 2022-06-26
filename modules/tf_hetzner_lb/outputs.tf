output "lb_id" {
  value = resource.hcloud_load_balancer.main.id
}

output "lb_ip" {
  value = resource.hcloud_load_balancer.main.ipv4
}
