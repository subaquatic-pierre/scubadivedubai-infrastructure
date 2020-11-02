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
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  depends_id           = ""
}

module "storefront" {
  source           = "./storefront"
  shop_domain_name = var.shop_domain_name
  refer_secret     = var.refer_secret
  ssl_cert_arn     = var.ssl_cert_arn
  tags             = var.tags
}

module "dns" {
  source           = "./dns"
  shop_domain_name = var.shop_domain_name
}


