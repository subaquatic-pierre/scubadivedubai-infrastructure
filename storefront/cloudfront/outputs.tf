# Root domain
output "domain_name_main" {
  value = aws_cloudfront_distribution.main.domain_name
}
output "hosted_zone_id_main" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}
output "distribution_id_main" {
  value = aws_cloudfront_distribution.main.id
}

# Shop domain




# Www domain
