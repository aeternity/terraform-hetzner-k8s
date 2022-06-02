module "superhero-io-dns-zone" {
  source          = "./modules/tf_hertzner_dns_zone"
  domain_name     = "superhero.io"
  create_dns_zone = local.create_dns_zone
}
