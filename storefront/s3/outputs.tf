# Root domain
output "bucket_id_main" {
  value = aws_s3_bucket.main.id
}
output "bucket_arn_main" {
  value = aws_s3_bucket.main.arn
}
output "website_endpoint_main" {
  value = aws_s3_bucket.main.website_endpoint
}
output "hosted_zone_id_main" {
  value = aws_s3_bucket.main.hosted_zone_id
}

# Www domain
output "bucket_id_www" {
  value = aws_s3_bucket.www.id
}
output "bucket_arn_www" {
  value = aws_s3_bucket.www.arn
}
output "website_endpoint_www" {
  value = aws_s3_bucket.www.website_endpoint
}
output "hosted_zone_id_www" {
  value = aws_s3_bucket.www.hosted_zone_id
}

# Shop domain






