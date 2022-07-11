module "superk8s-de-dns-zone" {
  source          = "./modules/tf_hetzner_dns_zone"
  domain_name     = "superk8s.de"
  create_dns_zone = local.create_dns_zone
}
