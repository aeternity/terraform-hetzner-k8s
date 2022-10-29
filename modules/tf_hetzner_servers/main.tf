terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.34.3"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "2.1.0"
    }
     aws = {
      source  = "hashicorp/aws"
    }
  }

  experiments      = [module_variable_optional_attrs]
  required_version = ">= 1.0"
}

locals {
  dns_ip   = var.internal_dns_record == true ? resource.hcloud_server_network.main.*.ip : hcloud_server.main.*.ipv4_address
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
  lifecycle {
    ignore_changes = [
      ssh_keys,
    ]
  }
}

resource "hcloud_server_network" "main" {
  count     = var.instance_count
  network_id = var.network_id
  server_id  = element(hcloud_server.main.*.id, count.index)
  #ip = cidrhost(var.subnet_id_range, count.index + var.ip_counter)
}

resource "hcloud_volume" "main" {
  count    = var.attached_disk ? var.instance_count : 0
  name     = var.instance_count != "1" ? "${var.name}-disk-${format("%03d", count.index)}" : "${var.name}-disk"
  size     = var.disk_size
  location = var.location
  format   = var.disk_format
  depends_on = [
    hcloud_server.main,
    hcloud_server_network.main,
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

#resource "hetznerdns_record" "main" {
  #count   = var.attach_dns ? var.instance_count : 0
  #zone_id = var.dns_record.dns_zone_id
  #name    = var.instance_count != "1" ? "${var.dns_record.dns_name}-${count.index}" : "${var.dns_record.dns_name}"
  #value   = element(local.dns_ip, count.index)
  #type    = var.dns_record.dns_record_type
  #ttl     = var.dns_record.dns_ttl
#}

resource "aws_route53_record" "www" {
  count   = var.attach_dns ? var.instance_count : 0
  zone_id = var.dns_record.dns_zone_id
  name    = var.instance_count != "1" ? "${var.dns_record.dns_name}-${count.index}" : "${var.dns_record.dns_name}"
  type    = var.dns_record.dns_record_type
  ttl     = var.dns_record.dns_ttl
  records = [element(local.dns_ip, count.index)]
}

resource "hcloud_load_balancer_target" "main" {
  count            = var.attach_to_lb ? var.instance_count : 0
  type             = var.lb_target_type
  load_balancer_id = var.load_balancer_id
  server_id        = element(hcloud_server.main.*.id, count.index)
  use_private_ip   = true
  depends_on = [
    hcloud_server.main,
    hcloud_server_network.main,
  ]
}
