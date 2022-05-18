terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.33.2"
    }
  }
}

resource "hcloud_server" "main" {
  count              = var.instance_count
  name               = var.instance_count != "1" ? "${var.name}-${format("%03d", count.index)}" : var.name
  server_type        = var.server_type
  image              = var.image
  location           = var.location
  ssh_keys           = var.ssh_keys
  firewall_ids       = var.firewall_ids
  delete_protection  = var.delete_protection
  placement_group_id = hcloud_placement_group.main.id
  labels             = var.labels

  network {
    network_id = var.network_id
    ip         = var.ip
    alias_ips  = var.alias_ips
  }
}

resource "hcloud_volume" "main" {
  count    = var.attached_disk ? var.instance_count : 0
  name     = var.instance_count != "1" ? "${var.name}-disk-${format("%03d", count.index)}" : "${var.name}-disk"
  size     = var.disk_size
  location = var.location
  format   = var.disk_format
  depends_on = [
    hcloud_server.main,
  ]
}

resource "hcloud_volume_attachment" "main" {
  count     = var.attached_disk ? var.instance_count : 0
  volume_id = element(hcloud_volume.main.*.id, count.index)
  server_id = element(hcloud_server.main.*.id, count.index)
  automount = true
  depends_on = [
    hcloud_server.main,
    hcloud_volume.main,
  ]
}

resource "hcloud_floating_ip" "main" {
  count     = var.floating_ip ? var.instance_count : 0
  type      = "ipv4"
  server_id = element(hcloud_server.main.*.id, count.index)
}

resource "hcloud_placement_group" "main" {
  name   = var.name
  type   = "spread"
  labels = var.labels
}
