resource "aws_codebuild_project" "static_web_build" {
  name          = "${var.tags["name"]}-${var.tags["layer"]}-${var.github_repo["prod_branch"]}-codebuild"
  service_role  = var.codebuild_role
  badge_enabled = false
  tags          = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:3.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.codebuild_bucket.bucket}/cache"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/buildspec.yml", {
      bucket_name     = var.storefront_site_bucket.bucket,
      env             = "development",
      distribution_id = var.storefront_cf_distribution
    })
  }
}
