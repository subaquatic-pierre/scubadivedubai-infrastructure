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
  ssl_cert_arn     = var.ssl_cert_arn
}
