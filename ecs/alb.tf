resource "aws_lb" "api_lb" {
  name               = "${var.tags["Name"]}-api-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.lb.id]
  tags               = var.tags
}

resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_lb_target_group" "api_target_group" {
  name        = "masha-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "api_https_listener" {
  load_balancer_arn = aws_lb.api_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_cert_arn

  lifecycle {
    create_before_destroy = true
  }

  default_action {
    target_group_arn = aws_lb_target_group.api_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "api_http_listener" {
  load_balancer_arn = aws_lb.api_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
