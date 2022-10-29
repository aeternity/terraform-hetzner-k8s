resource "aws_route53_record" "main" {
  for_each = var.dns_records
  zone_id  = lookup(each.value, "zone_id")
  records  = [lookup(each.value, "records")]
  type     = lookup(each.value, "type")
  ttl      = lookup(each.value, "ttl", 300)
  name     = lookup(each.value, "name")
}
