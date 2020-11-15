resource "aws_s3_bucket" "api_media_static" {
  bucket = "${var.prefix}-media"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  tags = var.tags
}
