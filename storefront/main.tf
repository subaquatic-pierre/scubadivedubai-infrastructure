module "s3" {
  source = "./s3"

  tags             = var.tags
  shop_domain_name = var.shop_domain_name
  refer_secret     = var.refer_secret
  environment      = var.environment
}

module "cloudfront_distribution" {
  source = "./cloudfront"

  refer_secret             = var.refer_secret
  shop_domain_name         = var.shop_domain_name
  tags                     = var.tags
  ssl_cert_arn             = var.ssl_cert_arn
  s3_website_endpoint_main = module.s3.website_endpoint_main
}
