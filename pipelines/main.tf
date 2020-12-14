data "aws_region" "current" {}

module "storefront_pipeline" {
  source = "./storefront"

  aws_account_id             = var.aws_account_id
  prefix                     = "${var.tags["Name"]}-storefront"
  tags                       = var.tags
  storefront_site_bucket     = var.storefront_site_bucket
  storefront_cf_distribution = var.storefront_cf_distribution
  github_account             = var.github_account
  github_token               = var.github_token
  github_repo                = var.storefront_github_repo

  codebuild_role    = aws_iam_role.codebuild_role.arn
  codepipeline_role = aws_iam_role.codepipeline_role.arn
}

module "dashboard_pipeline" {
  source = "./dashboard"

  aws_account_id            = var.aws_account_id
  prefix                    = "${var.tags["Name"]}-dashboard"
  tags                      = var.tags
  dashboard_site_bucket     = var.dashboard_site_bucket
  dashboard_cf_distribution = var.dashboard_cf_distribution
  github_account            = var.github_account
  github_token              = var.github_token
  github_repo               = var.dashboard_github_repo

  codebuild_role    = aws_iam_role.codebuild_role.arn
  codepipeline_role = aws_iam_role.codepipeline_role.arn
}

module "api_pipeline" {
  source = "./api"

  aws_account_id   = var.aws_account_id
  prefix           = "${var.tags["Name"]}-api"
  region           = data.aws_region.current.name
  tags             = var.tags
  github_account   = var.github_account
  github_token     = var.github_token
  github_repo      = var.api_github_repo
  subnet_ids       = var.subnet_ids
  api_ecr_repo_url = var.api_ecr_repo_url
  build_secrets    = var.build_secrets

  codebuild_role    = aws_iam_role.codebuild_role.arn
  codepipeline_role = aws_iam_role.codepipeline_role.arn
}
