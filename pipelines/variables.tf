variable "aws_account_id" {}
variable "tags" {}
variable "github_token" {}
variable "github_account" {}
variable "api_ecr_repo_url" {}
variable "storefront_github_repo" {}
variable "dashboard_github_repo" {}
variable "api_github_repo" {}

variable "build_secrets" {
  type        = map(string)
  description = "All secrets used in building images"
}

# From vpc module
variable "subnet_ids" {}

# From storefront module
variable "storefront_site_bucket" {}
variable "storefront_cf_distribution" {}

# From dashboard module
variable "dashboard_site_bucket" {}
variable "dashboard_cf_distribution" {}
