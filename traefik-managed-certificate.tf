terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.34.3"
    }
  }
}

resource "hcloud_managed_certificate" "main" {
  name         = "${local.env_human}.superk8s.de"
  domain_names = ["*.${local.env_human}.superk8s.de", "superk8s.de"]
}
