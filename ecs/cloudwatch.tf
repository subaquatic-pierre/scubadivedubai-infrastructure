resource "aws_cloudwatch_log_group" "ecs" {
  name = "ecs-group/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "ecs-group/app-scubadivedubai"
}

resource "aws_cloudwatch_log_group" "web_app" {
  name = "${var.tags["Name"]}-logs"
  tags = var.tags
}

