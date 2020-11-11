# Root domain
variable "domain_name" {}
variable "cf_domain_name_main" {}
variable "cf_hosted_zone_id_main" {}

# Www domain
variable "www_domain_name" {}
variable "cf_domain_name_www" {}
variable "cf_hosted_zone_id_www" {}

# Shop domain
variable "shop_domain_name" {}
variable "alb_dns" {}
variable "alb_zone_id" {}
