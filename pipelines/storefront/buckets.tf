
resource "aws_s3_bucket" "codebuild_bucket" {
  bucket = "${var.tags["name"]}-${var.tags["layer"]}-${var.github_repo["prod_branch"]}-pipeline"

  acl           = "private"
  force_destroy = true

  tags = var.tags
}
