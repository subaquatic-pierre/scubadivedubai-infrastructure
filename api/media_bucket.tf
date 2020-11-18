resource "aws_s3_bucket" "api_media" {
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

resource "aws_cloudfront_origin_access_identity" "media_bucket" {
  comment = "Media bucket scubadivedubai.com storefront access identity"
}

resource "aws_cloudfront_distribution" "media_bucket" {
  aliases = ["media.${var.domain_name}"]
  enabled = true
  comment = "Media bucket CDN for scubadivedubai.com"

  origin {
    domain_name = aws_s3_bucket.api_media.bucket_regional_domain_name
    origin_id   = "S3-media.${var.domain_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.media_bucket.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = "S3-media.${var.domain_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_policy" "media_bucket" {
  bucket = aws_s3_bucket.api_media.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
              "AWS": "${aws_cloudfront_origin_access_identity.media_bucket.iam_arn}"
              },
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.api_media.bucket}/*"
            ]
        }
    ]
}
POLICY
}

