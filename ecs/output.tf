output "alb_dns" {
  value = aws_lb.api_lb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.api_lb.zone_id
}
