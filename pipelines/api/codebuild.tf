resource "aws_codebuild_project" "api_build" {
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
      account_id         = var.aws_account_id
      repository_url     = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.tags["name"]}-${var.tags["layer"]}"
      region             = var.region
      cluster_name       = "${var.tags["name"]}-${var.tags["layer"]}-cluster"
      container_name     = "${var.tags["name"]}-${var.tags["layer"]}"
      security_group_ids = join(",", var.subnet_ids)
    })
  }
}
