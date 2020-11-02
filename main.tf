terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "scubadivedubai-terraform-backend"
    key    = "scubadivedubai-terraform-backend"
    region = "us-east-1"
  }
}

module "network" {
  source               = "./network"
  name                 = var.name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  depends_id           = ""
}

module "storefront" {
  source = "./storefront"

  environment      = var.environment
  shop_domain_name = var.shop_domain_name
  refer_secret     = var.refer_secret
  tags             = var.tags
  ssl_cert_arn     = module.dns.ssl_cert_arn_main
}

module "dns" {
  source = "./dns"

  shop_domain_name  = var.shop_domain_name
  domain_name       = var.domain
  cf_domain_name    = module.storefront.cf_domain_name
  cf_hosted_zone_id = module.storefront.cf_hosted_zone_id
}


