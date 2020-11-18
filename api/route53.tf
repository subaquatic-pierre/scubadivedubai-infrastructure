data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "api_lb" {
  zone_id         = data.aws_route53_zone.main.id
  name            = "api.${var.domain_name}"
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.api_lb.dns_name
    zone_id                = aws_lb.api_lb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "media_bucket" {
  zone_id         = data.aws_route53_zone.main.id
  name            = "media.${var.domain_name}"
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = aws_cloudfront_distribution.media_bucket.domain_name
    zone_id                = aws_cloudfront_distribution.media_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "static_bucket" {
  zone_id         = data.aws_route53_zone.main.id
  name            = "static.${var.domain_name}"
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = aws_cloudfront_distribution.static_bucket.domain_name
    zone_id                = aws_cloudfront_distribution.static_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}
