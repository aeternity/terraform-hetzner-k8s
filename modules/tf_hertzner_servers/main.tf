terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.0"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }

  experiments      = [module_variable_optional_attrs]
  required_version = ">= 1.0"
}



resource "hcloud_server" "main" {
  count              = var.instance_count
  name               = var.instance_count != "1" ? "${var.name}-${format("%03d", count.index)}" : var.name
  server_type        = var.server_type
  image              = var.image
  location           = var.location
  ssh_keys           = var.ssh_keys
  delete_protection  = var.delete_protection
  placement_group_id = hcloud_placement_group.main.id
  labels             = var.labels
  firewall_ids       = [element(hcloud_firewall.main.*.id, count.index)]
  network {
    network_id = var.network_id
    ip = var.cidr_prefix != null ? cidrhost(var.cidr_prefix, count.index + 10) : var.ip
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
resource "hcloud_firewall" "main" {
  count  = var.attach_firewall ? 1 : 0
  name   = "${var.name}-firewall"
  labels = var.labels

  dynamic "rule" {
    for_each = var.firewall_rules

    content {
      direction       = rule.value.direction
      protocol        = rule.value.protocol
      port            = rule.value.port
      source_ips      = rule.value.source_ips
      destination_ips = rule.value.destination_ips
      description     = rule.value.description
    }
  }
}

resource "hetznerdns_record" "main" {
  count   = var.attach_dns ? var.instance_count : 0
  zone_id = var.dns_record.dns_zone_id
  name    = var.instance_count != "1" ? "${var.dns_record.dns_name}-${count.index}" : "${var.dns_record.dns_name}"
  value   = element(hcloud_server.main.*.ipv4_address, count.index)
  type    = var.dns_record.dns_record_type
  ttl     = var.dns_record.dns_ttl
}
