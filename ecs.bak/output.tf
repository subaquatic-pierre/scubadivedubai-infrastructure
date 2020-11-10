output "service_name" {
  value = aws_ecs_service.web_api.name
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.web_app.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

