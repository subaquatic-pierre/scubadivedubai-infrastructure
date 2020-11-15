resource "aws_cloudfront_origin_access_identity" "dashboard" {
  comment = "scubadivedubai.com dashboard access identity"
}

resource "aws_cloudfront_distribution" "dashboard" {
  aliases             = ["dashboard.${var.domain_name}"]
  default_root_object = "index.html"
  enabled             = true
  comment             = "Dashboard CDN for scubadivedubai.com"

  origin {
    domain_name = aws_s3_bucket.dashboard.bucket_regional_domain_name
    origin_id   = "S3-dashboard.${var.domain_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.dashboard.cloudfront_access_identity_path
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
    target_origin_id       = "S3-dashboard.${var.domain_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  tags = var.tags
}
