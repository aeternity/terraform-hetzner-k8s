terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.34.3"
    }
  }
}

resource "hcloud_network" "main" {
  name     = var.network_name
  ip_range = var.network_ip_range
}

resource "hcloud_network_subnet" "public" {
  network_id = hcloud_network.main.id
  type = var.subnet_type
  network_zone = var.subnet_network_zone
  ip_range   = var.public_subnet_ip_ranges
}

resource "hcloud_network_subnet" "private" {
  network_id = hcloud_network.main.id
  type = var.subnet_type
  network_zone = var.subnet_network_zone
  ip_range   = var.private_subnet_ip_ranges
}
