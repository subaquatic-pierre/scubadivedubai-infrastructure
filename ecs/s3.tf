resource "aws_s3_bucket" "api_media_static" {
  bucket = "${var.tags["Name"]}-api-media-static"
  acl    = "private"

  tags = var.tags
}
