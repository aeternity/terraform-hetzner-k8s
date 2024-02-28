resource "random_string" "id_suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  # use this variable as prefix for all resource names. This avoids conflicts with globally unique resources (all resources with a hostname)
  env       = "${terraform.workspace}-${random_string.id_suffix.result}"
  env_human = terraform.workspace

  cluster_domain                  = "superhero.com"
  common_service_listen_port      = "6443"
  common_service_destination_port = "6443"
  common_service_protocol         = "tcp"
  common_lb_type                  = "lb11"
  common_location                 = "nbg1"

  env_config = {

    dev = {
      subnet_network_zone            = "eu-central"
      subnet_type                    = "cloud"
      network_ip_range               = "10.0.0.0/16"
      private_subnet_ip_ranges       = "10.0.2.0/24"
      public_subnet_ip_ranges        = "10.0.1.0/24"
      k8s_master_instance_count      = "3"
      k8s_master_server_type         = "cx41"
      k8s_master_image               = "ubuntu-20.04"
      k8s_master_disk_format         = "ext4"
      k8s_master_disk_size           = "100"
      k8s_master_location            = "nbg1"
      k8s_master_ssh_keys            = ["hetzner"]
      k8s_worker_instance_count      = "3"
      k8s_worker_server_type         = "cx31"
      k8s_worker_image               = "ubuntu-20.04"
      k8s_worker_disk_format         = "ext4"
      k8s_worker_disk_size           = "10"
      k8s_worker_location            = "nbg1"
      k8s_worker_ssh_keys            = ["hetzner"]
      ssh_keys                       = ["hertzner"]
      common_server_type             = "cx11"
      sentry_server_type             = "cx31"
      snipe_server_type              = "cx41"
      bitcoin_server_type            = "cx51"
      bitcoin_testnet_server_type    = "cx51"
      middlewares_server_type        = "cx51"
      plausible_server_type          = "cx31"
      common_image                   = "ubuntu-20.04"
      common_disk_format             = "ext4"
      common_disk_size               = "50"
      iredmail_disk_size             = "100"
      bitcoin_disk_size              = "2000"
      bitcoin_testnet_disk_size      = "1000"
      middlewares_disk_size          = "1000"
      common_ssh_keys                = ["hetzner"]
      common_instance_count          = "1"
      pg_backend_instance_count      = "1"
      ohmyform_instance_count        = "1"
      sentry_instance_count          = "1"
      plausible_instance_count       = "1"
      statping_instance_count        = "1"
      iredmail_instance_count        = "0"
      wordpress_instance_count       = "0"
      snipe_instance_count           = "0"
      v-tiger_instance_count         = "0"
      dogecoin_instance_count        = "0"
      bitcoin_instance_count         = "0"
      bitcoin_testnet_instance_count = "0"
      middlewares_instance_count     = "1"
      openvpn_image                  = "debian-11"
      bitcoin_image                  = "debian-11"
      bitcoin_image                  = "debian-11"
      middlewares_image              = "debian-11"
      dns_records = {
        "*.dev.A" = {
          records = "167.235.109.162"
          type    = "A"
          name    = "*.dev.service"
          zone_id = data.aws_route53_zone.aepps.id
          ttl     = "300"
        },
      }
    }
    prd = {
      subnet_network_zone            = "eu-central"
      subnet_type                    = "cloud"
      network_ip_range               = "172.16.0.0/12"
      public_subnet_ip_ranges        = "172.16.1.0/24"
      private_subnet_ip_ranges       = "172.16.2.0/24"
      k8s_master_instance_count      = "3"
      k8s_master_server_type         = "cx41"
      k8s_master_image               = "ubuntu-20.04"
      k8s_master_disk_format         = "ext4"
      k8s_master_disk_size           = "100"
      k8s_master_location            = "nbg1"
      k8s_master_ssh_keys            = ["hetzner-prd"]
      k8s_worker_instance_count      = "5"
      k8s_worker_server_type         = "cx41"
      k8s_worker_image               = "ubuntu-20.04"
      k8s_worker_disk_format         = "ext4"
      k8s_worker_disk_size           = "10"
      k8s_worker_location            = "nbg1"
      k8s_worker_ssh_keys            = ["hetzner-prd"]
      common_server_type             = "cx11"
      plausible_server_type          = "cx31"
      sentry_server_type             = "cx31"
      snipe_server_type              = "cx41"
      dogecoin_server_type           = "cx41"
      bitcoin_server_type            = "cx51"
      bitcoin_testnet_server_type    = "cx51"
      middlewares_server_type        = "cx51"
      common_image                   = "ubuntu-20.04"
      common_disk_format             = "ext4"
      common_disk_size               = "50"
      dogecoin_disk_size             = "200"
      bitcoin_disk_size              = "3000"
      bitcoin_testnet_disk_size      = "1000"
      middlewares_disk_size          = "1000"
      iredmail_disk_size             = "100"
      common_ssh_keys                = ["hetzner-prd"]
      ssh_keys                       = ["hetzner-prd"]
      common_instance_count          = "1"
      pg_backend_instance_count      = "0"
      ohmyform_instance_count        = "1"
      sentry_instance_count          = "0"
      plausible_instance_count       = "0"
      statping_instance_count        = "0"
      iredmail_instance_count        = "1"
      wordpress_instance_count       = "1"
      v-tiger_instance_count         = "1"
      snipe_instance_count           = "1"
      dogecoin_instance_count        = "1"
      bitcoin_instance_count         = "1"
      bitcoin_testnet_instance_count = "1"
      middlewares_instance_count     = "1"
      openvpn_image                  = "debian-11"
      dogecoin_image                 = "debian-11"
      bitcoin_image                  = "debian-11"
      bitcoin_testnet_image          = "debian-11"
      middlewares_image              = "debian-11"

      dns_records = {
        "*.prd.A" = {
          records = "167.235.109.75"
          type    = "A"
          name    = "*.prd.service"
          zone_id = data.aws_route53_zone.aepps.id
          #zone_id = "Z8J0F7X8EN90Z"
          ttl = "300"
        },
      }
    }

    stg = {
      subnet_network_zone            = "eu-central"
      subnet_type                    = "cloud"
      network_ip_range               = "192.168.0.0/16"
      public_subnet_ip_ranges        = "192.168.1.0/24"
      private_subnet_ip_ranges       = "192.168.2.0/24"
      k8s_master_instance_count      = "3"
      k8s_master_server_type         = "cx41"
      k8s_master_image               = "ubuntu-20.04"
      k8s_master_disk_format         = "ext4"
      k8s_master_disk_size           = "100"
      k8s_master_location            = "nbg1"
      k8s_master_ssh_keys            = ["hetzner"]
      k8s_worker_instance_count      = "10"
      k8s_worker_server_type         = "cx41"
      k8s_worker_image               = "ubuntu-20.04"
      k8s_worker_disk_format         = "ext4"
      k8s_worker_disk_size           = "100"
      k8s_worker_location            = "nbg1"
      k8s_worker_ssh_keys            = ["hetzner"]
      common_server_type             = "cx11"
      plausible_server_type          = "cx31"
      sentry_server_type             = "cx31"
      snipe_server_type              = "cx41"
      bitcoin_server_type            = "cx51"
      bitcoin_testnet_server_type    = "cx51"
      middlewares_server_type        = "cx51"
      common_image                   = "ubuntu-20.04"
      common_disk_format             = "ext4"
      common_disk_size               = "50"
      iredmail_disk_size             = "100"
      bitcoin_disk_size              = "1500"
      bitcoin_testnet_disk_size      = "1000"
      middlewares_disk_size          = "1000"
      common_ssh_keys                = ["hetzner"]
      ssh_keys                       = ["hetzner"]
      common_instance_count          = "1"
      pg_backend_instance_count      = "0"
      ohmyform_instance_count        = "0"
      sentry_instance_count          = "0"
      plausible_instance_count       = "0"
      statping_instance_count        = "0"
      iredmail_instance_count        = "0"
      wordpress_instance_count       = "0"
      v-tiger_instance_count         = "0"
      snipe_instance_count           = "0"
      dogecoin_instance_count        = "0"
      bitcoin_instance_count         = "0"
      bitcoin_testnet_instance_count = "0"
      middlewares_instance_count     = "0"
      openvpn_image                  = "debian-11"
      bitcoin_image                  = "debian-11"
      bitcoin_testnet_image          = "debian-11"
      middlewares_image              = "debian-11"
      dns_records = {
        "*.stg.A" = {
          records = "167.235.109.124"
          type    = "A"
          name    = "*.stg.service"
          zone_id = data.aws_route53_zone.aepps.id
          ttl     = "300"
        },
      }
    }
  }
  config = merge(lookup(local.env_config, terraform.workspace, {}))

  standard_tags = {
    "env"         = local.env
    "project"     = "superhero"
    "github-repo" = "terraform-hetzner-k8s"
    "github-org"  = "aeternity"
  }

  tag_query = join(",\n", [for key in keys(local.standard_tags) : <<JSON
    {
      "Key": "${key}", 
      "Values": ["${lookup(local.standard_tags, key)}"]
    }
  JSON
  ])
}
