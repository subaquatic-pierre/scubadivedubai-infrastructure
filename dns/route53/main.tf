
resource "aws_route53_record" "web" {
  zone_id = var.aws_route53_zone.main.zone_id
  name    = var.shop_domain_name
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}
