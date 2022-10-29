provider "aws" {
  region = "eu-central-1"
}

data "aws_route53_zone" "aepps" {
  name = "aepps.com"
}

#zone_id     = data.aws_route53_zone.aepps.id
