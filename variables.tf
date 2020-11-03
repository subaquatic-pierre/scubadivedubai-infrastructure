# ------
# General Variables
# ------
variable "tags" {
  type        = map(string)
  description = "Tags"
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
variable "refer_secret" {
  type        = string
  description = "A secret string to authenticate CF requests to S3"
}

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


