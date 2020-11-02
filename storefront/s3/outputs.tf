output "main_bucket_id" {
  value = aws_s3_bucket.main.id
}

output "main_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "website_endpoint_main" {
  value = "${var.shop_domain_name}.s3-website-${data.aws_region.main.name}.amazonaws.com"
}

output "hosted_zone_id_main" {
  value = aws_s3_bucket.main.hosted_zone_id
}
