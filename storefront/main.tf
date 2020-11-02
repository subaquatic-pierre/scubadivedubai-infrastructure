module "s3_buckets" {
  source = "./s3buckets"

  tags             = var.tags
  shop_domain_name = var.shop_domain_name
  refer_secret     = var.refer_secret
}

module "cloudfront_distribution" {
  source = "./cloudfront"

  shop_domain_name = var.shop_domain_name
  tags             = var.tags
  ssl_cert_arn     = module.dns.acm.aws_acm_certificate_validation.cert.certificate_arn
}
