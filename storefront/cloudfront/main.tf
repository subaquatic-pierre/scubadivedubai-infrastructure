resource "aws_cloudfront_distribution" "main" {
  is_ipv6_enabled = true

  http_version = "http2"

  origin {
    origin_id   = "origin-${var.domain_name}"
    domain_name = var.s3_website_endpoint_main

    custom_origin_config {
      origin_protocol_policy = "http-only"

      http_port  = "80"
      https_port = "443"

      origin_ssl_protocols = ["TLSv1.2"]
    }
    custom_header {
      name  = "User-Agent"
      value = var.refer_secret
    }
  }

  enabled             = true
  default_root_object = "index.html"

  custom_error_response {
    error_code            = "404"
    error_caching_min_ttl = "300"
    response_code         = "200"
    response_page_path    = "/404.html"
  }

  default_cache_behavior {
    target_origin_id = "origin-${var.domain_name}"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_cloudfront_distribution" "www" {
  http_version = "http2"

  origin {
    origin_id   = "origin-${var.www_domain_name}"
    domain_name = var.s3_website_endpoint_www

    custom_origin_config {
      origin_protocol_policy = "http-only"

      http_port  = "80"
      https_port = "443"

      origin_ssl_protocols = ["TLSv1.2"]
    }

    custom_header {
      name  = "User-Agent"
      value = var.refer_secret
    }

  }

  enabled = true

  aliases = [var.www_domain_name]

  price_class = "PriceClass_100"

  default_cache_behavior {
    target_origin_id = "origin-${var.www_domain_name}"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}


