resource "aws_cloudwatch_log_group" "ecs" {
  name = "tf-ecs-group/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "tf-ecs-group/app-scubadivedubai"
}

resource "aws_cloudwatch_log_group" "web_app" {
  name = "${var.tags["name"]}-logs"
  tags = var.tags
}

