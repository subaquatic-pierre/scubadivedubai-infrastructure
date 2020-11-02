output "s3_bucket_id_main" {
  value = module.s3.main_bucket_id
}
output "s3_bucket_arn_main" {
  value = module.s3.main_bucket_arn
}

output "s3_website_endpoint" {
  value = module.s3.website_endpoint_main
}

output "s3_hosted_zone_id" {
  value = module.s3.hosted_zone_id_main
}

output "cf_domain_name" {
  value = module.cloudfront_distribution.cf_domain_name
}

output "cf_hosted_zone_id" {
  value = module.cloudfront_distribution.cf_hosted_zone_id
}

output "cf_distribution_id" {
  value = module.cloudfront_distribution.cf_distribution_id
}
