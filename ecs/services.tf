locals {
  security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.alb_sg.id,
    aws_security_group.ecs_sg.id,
  ]
}

resource "aws_ecs_service" "web_api" {
  name            = var.tags["name"]
  task_definition = aws_ecs_task_definition.web_api.arn
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  desired_count   = var.desired_tasks

  //  deployment_controller {
  //    type = "CODE_DEPLOY"
  //  }

  network_configuration {
    security_groups  = local.security_group_ids
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.tags["name"]}-cluster"
}

resource "aws_cloudwatch_log_group" "web_app" {
  name = "${var.tags["name"]}-logs"
  tags = var.tags
}

