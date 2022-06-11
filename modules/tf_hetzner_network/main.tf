terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.33.2"
    }
  }
}

resource "hcloud_network" "main" {
  count    = var.create_network ? 1 : 0
  name     = var.network_name
  ip_range = var.network_ip_range
}

resource "hcloud_network_subnet" "main" {
  count        = var.create_network && length(var.subnet_ip_ranges) > 0 ? length(var.subnet_ip_ranges) : 0
  type         = var.subnet_type
  ip_range     = var.subnet_ip_ranges[count.index]
  network_id   = hcloud_network.main[0].id
  network_zone = var.subnet_network_zone
}
