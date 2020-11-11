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
    key    = "tfstate/scubadivedubai-terraform-backend"
    region = "us-east-1"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.tags["Name"]}-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  tags = var.tags
}

module "storefront" {
  source = "./storefront"

  tags             = var.tags
  ssl_cert_arn     = var.ssl_cert_arn
  domain_name      = var.domain_name
  shop_domain_name = var.shop_domain_name
  www_domain_name  = var.www_domain_name
}

module "route53" {
  source = "./route53"

  domain_name            = var.domain_name
  cf_domain_name_main    = module.storefront.cf_domain_name_main
  cf_hosted_zone_id_main = module.storefront.cf_hosted_zone_id_main
  www_domain_name        = var.www_domain_name
  cf_domain_name_www     = module.storefront.cf_domain_name_www
  cf_hosted_zone_id_www  = module.storefront.cf_hosted_zone_id_www
  shop_domain_name       = var.shop_domain_name
  alb_dns                = module.ecs.alb_dns
  alb_zone_id            = module.ecs.alb_zone_id
}

module "pipelines" {
  source = "./pipelines"

  aws_account_id             = var.aws_account_id
  tags                       = var.tags
  storefront_site_bucket     = module.storefront.bucket_main
  storefront_cf_distribution = module.storefront.cf_distribution_id_main
  github_token               = var.github_token
  github_account             = var.github_account
  storefront_github_repo     = var.storefront_github_repo
  api_github_repo            = var.api_github_repo
  subnet_ids                 = module.vpc.public_subnets
  api_ecr_repo_url           = var.api_ecr_app_uri
}

module "ecs" {
  source = "./ecs"

  tags               = var.tags
  public_subnets     = var.public_subnet_cidrs
  azs                = var.availability_zones
  cidr               = var.vpc_cidr
  availability_zones = var.availability_zones
  ssl_cert_arn       = var.ssl_cert_arn
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  ecr_nginx_uri      = var.api_ecr_nginx_uri
  ecr_app_uri        = var.api_ecr_app_uri
}


