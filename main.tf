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
  # Www domain
  www_domain_name       = var.www_domain_name
  cf_domain_name_www    = module.storefront.cf_domain_name_www
  cf_hosted_zone_id_www = module.storefront.cf_hosted_zone_id_www
  # Shop domain
  shop_domain_name = var.shop_domain_name
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
  subnet_ids                 = module.network.public_subnet_ids
  api_ecr_repo_url           = var.api_ecr_repo_url
}

module "ecs" {
  source = "./ecs"

  domain_name        = var.domain_name
  github_repo_name   = var.api_github_repo["name"]
  availability_zones = var.availability_zones
  tags               = var.tags
  ssl_cert_arn       = var.ssl_cert_arn
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  api_ecr_repo_url   = var.api_ecr_repo_url

  container_name = "${var.tags["name"]}-api"
  alb_port       = "3000"
  container_port = "3000"

  desired_task_cpu    = "1024"
  desired_task_memory = "2048"

  desired_tasks     = 1
  min_tasks         = 2
  max_tasks         = 3
  cpu_to_scale_down = 20
  cpu_to_scale_up   = 80

  environment_variables = var.api_env_vars

}

