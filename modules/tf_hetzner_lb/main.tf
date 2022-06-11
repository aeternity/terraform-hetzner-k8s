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
}

resource "hcloud_load_balancer" "main" {
  name               = var.name
  load_balancer_type = var.lb_type
  location           = var.lb_location
}

resource "hcloud_load_balancer_service" "main" {
  load_balancer_id = hcloud_load_balancer.main.id
  listen_port      = var.service_listen_port
  destination_port = var.service_destination_port
  protocol         = var.service_protocol
}

