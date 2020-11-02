output "s3_bucket_id" {
  value = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "s3_website_endpoint" {
  value = "${var.shop_domain_name}.s3-website-${data.aws_region.main.name}.amazonaws.com"
}

output "s3_hosted_zone_id" {
  value = aws_s3_bucket.main.hosted_zone_id
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.main.*.domain_name
}

output "cf_hosted_zone_id" {
  value = aws_cloudfront_distribution.main.*.hosted_zone_id
}

output "cf_distribution_id" {
  value = caws_cloudfront_distribution.main.*.id
}
