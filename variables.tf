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

variable "build_secrets" {
  type        = map(string)
  description = "All secrets used in building images"
}

variable "storefront_github_repo" {
  type        = map(string)
  description = "Storefront repository"
}

variable "api_github_repo" {
  type        = map(string)
  description = "API repository"
}

variable "dashboard_github_repo" {
  type        = map(string)
  description = "Dashboard repository"
}

# ------
# ECS Variables
# ------

variable "api_ecr_app_uri" {
  type        = string
  description = "API App ECR repository uri"
}

variable "api_ecr_nginx_uri" {
  type        = string
  description = "API Nginx ECR repository uri"
}

# ------
# Domain Variables
# ------
variable "domain_name" {
  type        = string
  description = "Root Route53 domain name"
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
  type = list(any)
}

variable "public_subnet_cidrs" {
  type = list(any)
}

variable "availability_zones" {
  type = list(any)
}


