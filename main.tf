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
  tags                 = var.tags
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "storefront" {
  source = "./storefront"

  refer_secret = var.refer_secret
  tags         = var.tags
  ssl_cert_arn = var.ssl_cert_arn

  # Root domain
  domain_name = var.domain_name

  # Shop domain
  shop_domain_name = var.shop_domain_name

  # Www domain
  www_domain_name = var.www_domain_name
}

module "route53" {
  source = "./route53"

  # Root domain
  domain_name            = var.domain_name
  cf_domain_name_main    = module.storefront.cf_domain_name_main
  cf_hosted_zone_id_main = module.storefront.cf_hosted_zone_id_main

  # Shop domain
  shop_domain_name = var.shop_domain_name

  # Www domain
  www_domain_name = var.www_domain_name
}


