resource "aws_alb" "app_alb" {
  name            = "${var.tags["name"]}-alb"
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.alb_sg.id, aws_security_group.app_sg.id]

  tags = var.tags
}

resource "aws_alb_target_group" "api_target_group" {
  name_prefix = substr(var.tags["name"], 0, 5)
  port        = var.container_port
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  # target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  # health_check {
  #   path = "/"
  #   port = var.container_port
  # }

  depends_on = [aws_alb.app_alb]
}

# resource "aws_alb_listener" "web_app" {
#   load_balancer_arn = aws_alb.app_alb.arn
#   port              = var.alb_port
#   protocol          = "HTTP"
#   depends_on        = [aws_alb_target_group.api_target_group]

#   lifecycle {
#     create_before_destroy = true
#   }

#   default_action {
#     target_group_arn = aws_alb_target_group.api_target_group.arn
#     type             = "forward"
#   }
# }

resource "aws_alb_listener" "web_app_ssl" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"

  certificate_arn = var.ssl_cert_arn

  lifecycle {
    create_before_destroy = true
  }

  default_action {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "http_redirect_https" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  lifecycle {
    create_before_destroy = true
  }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# data "aws_route53_zone" "selected" {
#   count = local.can_domain ? 1 : 0

#   name = "${var.domain_name}."
# }

# resource "aws_route53_record" "alb_alias" {
#   count = local.can_domain ? 1 : 0

#   name    = var.domain_name
#   zone_id = data.aws_route53_zone.selected[0].zone_id
#   type    = "A"

#   lifecycle {
#     create_before_destroy = true
#   }

#   alias {
#     name                   = aws_alb.app_alb.dns_name
#     zone_id                = aws_alb.app_alb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_alb_listener" "web_app_http" {
#   count = local.is_only_http ? 1 : 0

#   load_balancer_arn = aws_alb.app_alb.arn
#   port              = "80"
#   protocol          = "HTTP"
#   depends_on        = [aws_alb_target_group.api_target_group]

#   lifecycle {
#     create_before_destroy = true
#   }

#   default_action {
#     target_group_arn = aws_alb_target_group.api_target_group.arn
#     type             = "forward"
#   }
# }

