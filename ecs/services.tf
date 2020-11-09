resource "aws_ecs_cluster" "cluster" {
  name = "${var.tags["name"]}-cluster"
}


resource "aws_ecs_service" "web_api" {
  name            = var.tags["name"]
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.web_api.arn
  desired_count   = var.desired_tasks
  iam_role        = aws_iam_role.ecs_service.name

  load_balancer {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    container_name   = "nginx"
    container_port   = var.container_port
  }
}

