output "cf_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cf_hosted_zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}

output "cf_distribution_id" {
  value = aws_cloudfront_distribution.main.id
}
