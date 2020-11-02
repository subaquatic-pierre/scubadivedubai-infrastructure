output "main_bucket_id" {
  value = aws_s3_bucket.main.id
}

output "main_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "website_endpoint_main" {
  value = aws_s3_bucket.main.website_endpoint
}

output "hosted_zone_id_main" {
  value = aws_s3_bucket.main.hosted_zone_id
}
