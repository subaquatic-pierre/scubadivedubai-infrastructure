# ------
# General Variables
# ------

variable "environment" {}
variable "tags" {
  type        = map(string)
  description = "Tags"
  default = {
    "Project" : "scubdivedubai"
  }
}

# ------
# Storefront Variables
# ------
variable "refer_secret" {
  type        = string
  description = "A secret string to authenticate CF requests to S3"
}

variable "shop_domain_name" {
  type        = string
  description = "The FQDN of the website and also name of the S3 bucket"
}

variable "ssl_certificate_arn" {
  type        = string
  description = "ARN of the certificate covering the fqdn and its apex?"
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


