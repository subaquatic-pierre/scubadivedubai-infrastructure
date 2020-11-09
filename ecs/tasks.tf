data "aws_region" "current" {}

resource "aws_ecs_task_definition" "web_api" {
  family = "${var.tags["name"]}-app"
  container_definitions = templatefile("${path.module}/task_definition.json", {
    image               = var.api_ecr_repo_url
    region              = data.aws_region.current.name
    container_name      = var.container_name
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.web_app.name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
  })
}
