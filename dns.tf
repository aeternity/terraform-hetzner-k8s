module "aepps-dns-records" {
  source          = "./modules/tf_aws_dns_records"
  dns_records = local.config.dns_records
}
