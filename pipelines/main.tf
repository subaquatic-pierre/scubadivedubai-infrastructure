data "aws_region" "current" {}

module "storefront_pipeline" {
  source = "./storefront"

  aws_account_id             = var.aws_account_id
  tags                       = merge({ "layer" : "storefront" }, var.tags)
  storefront_site_bucket     = var.storefront_site_bucket
  storefront_cf_distribution = var.storefront_cf_distribution
  github_account             = var.github_account
  github_token               = var.github_token
  github_repo                = var.storefront_github_repo

  codebuild_role    = aws_iam_role.codebuild_role.arn
  codepipeline_role = aws_iam_role.codepipeline_role.arn
}

module "api_pipeline" {
  source = "./api"

  aws_account_id = var.aws_account_id
  region         = data.aws_region.current.name
  tags           = merge({ "layer" : "api" }, var.tags)
  github_account = var.github_account
  github_token   = var.github_token
  github_repo    = var.storefront_github_repo
  subnet_ids     = var.subnet_ids

  codebuild_role    = aws_iam_role.codebuild_role.arn
  codepipeline_role = aws_iam_role.codepipeline_role.arn
}
