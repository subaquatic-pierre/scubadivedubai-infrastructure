# Root domain
output "s3_bucket_id_main" {
  value = module.s3.bucket_id_main
}
output "s3_bucket_arn_main" {
  value = module.s3.bucket_arn_main
}
output "s3_website_endpoint_main" {
  value = module.s3.website_endpoint_main
}
output "s3_hosted_zone_id_main" {
  value = module.s3.hosted_zone_id_main
}
output "cf_domain_name_main" {
  value = module.cloudfront_distribution.domain_name_main
}
output "cf_hosted_zone_id_main" {
  value = module.cloudfront_distribution.hosted_zone_id_main
}
output "cf_distribution_id_main" {
  value = module.cloudfront_distribution.distribution_id_main
}

# Shop domain







# Www domain
