# ------
# General Variables
# ------
variable "tags" {
  type        = map(string)
  description = "Tags"
}
variable "aws_account_id" {}
variable "github_token" {}
variable "github_account" {}

# ------
# Repositories
# ------

variable "storefront_github_repo" {
  type        = map(string)
  description = "Storefront repository"
}

variable "api_github_repo" {
  type        = map(string)
  description = "API repository"
}

# ------
# ECS Variables
# ------

variable "api_ecr_repo_url" {
  type        = string
  description = "API AWS ECR repository"
}

variable "api_env_vars" {
  type        = map(string)
  description = "Environment variables for API ECR task definition"
}

# ------
# Domain Variables
# ------
variable "domain_name" {
  type        = string
  description = "Root Route53 domain name"
}

variable "shop_domain_name" {
  type        = string
  description = "The FQDN of the website and also name of the S3 bucket"
}

variable "www_domain_name" {
  type        = string
  description = "The FQDN of the website and also name of the S3 bucket"
}

variable "ssl_cert_arn" {
  type        = string
  description = "ARN of the certificate covering the fqdn and its apex?"
}

# ------
# Storefront Variables
# ------

# ------
# VPC Variables
# ------
variable "vpc_cidr" {}

variable "private_subnet_cidrs" {
  type = list
}

variable "public_subnet_cidrs" {
  type = list
}

variable "availability_zones" {
  type = list
}


