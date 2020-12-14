resource "aws_codebuild_project" "api_build" {
  name          = "${var.prefix}-codebuild"
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
      ACCOUNT_ID                   = var.aws_account_id
      REPOSITORY_URI               = var.api_ecr_repo_url
      REGION                       = var.region
      CONTAINER_NAME               = "app"
      DATABASE_URL                 = var.build_secrets["DATABASE_URL"]
      EMAIL_URL                    = var.build_secrets["EMAIL_URL"]
      DEFAULT_FROM_EMAIL           = var.build_secrets["DEFAULT_FROM_EMAIL"]
      STATIC_URL                   = var.build_secrets["STATIC_URL"]
      MEDIA_URL                    = var.build_secrets["MEDIA_URL"]
      CREATE_IMAGES_ON_DEMAND      = var.build_secrets["CREATE_IMAGES_ON_DEMAND"]
      API_URI                      = var.build_secrets["API_URI"]
      APP_MOUNT_URI                = var.build_secrets["APP_MOUNT_URI"]
      JAEGER_AGENT_HOST            = var.build_secrets["JAEGER_AGENT_HOST"]
      REDIS_URL                    = var.build_secrets["REDIS_URL"]
      PORT                         = var.build_secrets["PORT"]
      PYTHONUNBUFFERED             = var.build_secrets["PYTHONUNBUFFERED"]
      PROCESSES                    = var.build_secrets["PROCESSES"]
      OPENEXCHANGERATES_API_KEY    = var.build_secrets["OPENEXCHANGERATES_API_KEY"]
      SECRET_KEY                   = var.build_secrets["SECRET_KEY"]
      DEBUG                        = var.build_secrets["DEBUG"]
      ALLOWED_HOSTS                = var.build_secrets["ALLOWED_HOSTS"]
      PLAYGROUND_ENABLED           = var.build_secrets["PLAYGROUND_ENABLED"]
      AWS_MEDIA_BUCKET_NAME        = var.build_secrets["AWS_MEDIA_BUCKET_NAME"]
      AWS_STORAGE_BUCKET_NAME      = var.build_secrets["AWS_STORAGE_BUCKET_NAME"]
      AWS_ACCESS_KEY_ID            = var.build_secrets["AWS_ACCESS_KEY_ID"]
      AWS_SECRET_ACCESS_KEY        = var.build_secrets["AWS_SECRET_ACCESS_KEY"]
      AWS_MEDIA_CUSTOM_DOMAIN      = var.build_secrets["AWS_MEDIA_CUSTOM_DOMAIN"]
      AWS_STATIC_CUSTOM_DOMAIN     = var.build_secrets["AWS_STATIC_CUSTOM_DOMAIN"]
      ALLOWED_CLIENT_HOSTS         = var.build_secrets["ALLOWED_CLIENT_HOSTS"]
      DEFAULT_COUNTRY              = var.build_secrets["DEFAULT_COUNTRY"]
      DEFAULT_CURRENCY             = var.build_secrets["DEFAULT_CURRENCY"]
      GOOGLE_ANALYTICS_TRACKING_ID = var.build_secrets["GOOGLE_ANALYTICS_TRACKING_ID"]
      VATLAYER_ACCESS_KEY          = var.build_secrets["VATLAYER_ACCESS_KEY"]
    })
  }
}
