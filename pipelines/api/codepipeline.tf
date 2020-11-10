resource "aws_codepipeline" "prod_pipeline" {
  name     = "${var.tags["Name"]}-${var.tags["layer"]}-${var.github_repo["prod_branch"]}-pipeline"
  role_arn = var.codepipeline_role
  tags     = var.tags

  artifact_store {
    location = aws_s3_bucket.codebuild_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_account
        OAuthToken = var.github_token

        Repo   = var.github_repo["name"]
        Branch = var.github_repo["prod_branch"]
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["imagedefinitions"]

      configuration = {
        ProjectName = "${var.tags["Name"]}-${var.tags["layer"]}-${var.github_repo["prod_branch"]}-codebuild"
      }
    }
  }

  stage {
    name = "Production"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["imagedefinitions"]
      version         = "1"

      configuration = {
        ClusterName = "${var.tags["Name"]}-cluster"
        ServiceName = "${var.tags["Name"]}-api-service"
        FileName    = "imagedefinitions.json"
      }
    }
  }
}
