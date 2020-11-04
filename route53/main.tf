# Route 53 record for the static site
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "main" {
  zone_id         = data.aws_route53_zone.main.id
  name            = var.domain_name
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = var.cf_domain_name_main
    zone_id                = var.cf_hosted_zone_id_main
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id         = data.aws_route53_zone.main.id
  name            = var.www_domain_name
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = var.cf_domain_name_www
    zone_id                = var.cf_hosted_zone_id_www
    evaluate_target_health = false
  }
}
