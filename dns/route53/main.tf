resource "aws_route53_record" "web" {
  zone_id = var.aws_route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cf_domain_name_main
    zone_id                = var.cf_hosted_zone_id_main
    evaluate_target_health = false
  }
}
