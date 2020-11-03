# Route 53 record for the static site
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

module "route53" {
  source              = "./route53"
  aws_route53_zone_id = data.aws_route53_zone.main.id

  # Root domain
  domain_name            = var.domain_name
  cf_domain_name_main    = var.cf_domain_name_main
  cf_hosted_zone_id_main = var.cf_hosted_zone_id_main

  # Shop domain
  shop_domain_name = var.shop_domain_name

  # Www domain
  www_domain_name = var.www_domain_name

}

# module "acm" {
#   source              = "./acm"
#   aws_route53_zone_id = data.aws_route53_zone.main.id
#   domain_name         = var.domain_name
#   name                = var.name
# }
