resource "aws_s3_bucket" "main" {
  bucket = var.domain_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket" "www" {
  bucket = var.www_domain_name
  acl    = "public-read"

  website {
    redirect_all_requests_to = var.domain_name
  }

  force_destroy = true

  tags = var.tags
}

