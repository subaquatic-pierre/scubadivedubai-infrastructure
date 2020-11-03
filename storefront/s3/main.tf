resource "aws_s3_bucket" "main" {
  bucket = var.domain_name
  acl    = "private"
  policy = data.aws_iam_policy_document.bucket_policy.json

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket" "www" {
  bucket = var.www_domain_name
  acl    = "private"
  policy = data.aws_iam_policy_document.bucket_policy.json

  website {
    redirect_all_requests_to = var.domain_name
  }

  force_destroy = true

  tags = var.tags
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowedIPReadAccess"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.domain_name}/*",
      "arn:aws:s3:::${var.www_domain_name}/*",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = []
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    sid = "AllowCFOriginAccess"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.domain_name}/*",
      "arn:aws:s3:::${var.www_domain_name}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:UserAgent"

      values = [
        var.refer_secret,
      ]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

