data "aws_region" "current" {}

resource "aws_ecs_task_definition" "web_api" {
  family = "${var.tags["name"]}-app"
  container_definitions = templatefile("${path.module}/api-task.json", {
    image               = var.api_ecr_repo_url
    region              = data.aws_region.current.name
    container_name      = var.container_name
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.web_app.name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
    # Add endpoints as environment vaiables for the Application
    # environment_variables_str = "${replace(join(",",formatlist("{\"name\":%q,\"value\":%q}",keys(var.environment_variables),values(var.environment_variables))), "rds_endpoint", var.db_host_endpoint)}"
    environment_variables_str = join(
      ",",
      formatlist(
        "{\"name\":%q,\"value\":%q}",
        keys(var.environment_variables),
        values(var.environment_variables),
      ),
    )
  })

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}

