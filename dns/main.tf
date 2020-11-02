# Route 53 record for the static site
data "aws_route53_zone" "main" {
  name         = var.shop_domain_name
  private_zone = false
}

module "route53" {
  source = "./route53"

  shop_domain_name  = var.shop_domain_name
  aws_route53_zone  = data.aws_route53_zone
  cf_domain_name    = module.storefront.cf_domain_name
  cf_hosted_zone_id = module.storefront.cf_hosted_zone_id
}

module "acm" {
  source           = "./acm"
  aws_route53_zone = data.aws_route53_zone
  shop_domain_name = var.shop_domain_name
}
