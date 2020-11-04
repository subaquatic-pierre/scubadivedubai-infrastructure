# Root domain
output "bucket_main" {
  value = aws_s3_bucket.main
}
output "cf_domain_name_main" {
  value = aws_cloudfront_distribution.main.domain_name
}
output "cf_hosted_zone_id_main" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}
output "cf_distribution_id_main" {
  value = aws_cloudfront_distribution.main.id
}

# Www domain
output "cf_domain_name_www" {
  value = aws_cloudfront_distribution.www.domain_name
}
output "cf_hosted_zone_id_www" {
  value = aws_cloudfront_distribution.www.hosted_zone_id
}
output "cf_distribution_id_www" {
  value = aws_cloudfront_distribution.www.id
}

# Shop domain
