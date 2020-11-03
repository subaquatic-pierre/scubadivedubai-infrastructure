module "s3" {
  source = "./s3"

  tags         = var.tags
  domain_name  = var.domain_name
  refer_secret = var.refer_secret
  # shop_domain_name = var.shop_domain_name
}

module "cloudfront_distribution" {
  source = "./cloudfront"

  refer_secret = var.refer_secret
  tags         = var.tags
  ssl_cert_arn = var.ssl_cert_arn

  # Root domain
  domain_name              = var.domain_name
  s3_website_endpoint_main = module.s3.website_endpoint_main

  # Shop domain
  shop_domain_name = var.shop_domain_name

  # Www domain
  www_domain_name = var.www_domain_name
}
