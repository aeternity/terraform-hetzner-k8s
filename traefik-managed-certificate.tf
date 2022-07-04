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

resource "hcloud_managed_certificate" "main" {
  name         = "${local.env_human}.superk8s.de"
  domain_names = ["*.${local.env_human}.superk8s.de", "${local.env_human}.superk8s.de"]
}
