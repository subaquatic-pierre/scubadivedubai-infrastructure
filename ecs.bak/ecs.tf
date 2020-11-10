data "aws_region" "current" {}

resource "aws_ecs_cluster" "cluster" {
  name               = "${var.tags["Name"]}-cluster"
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
  tags               = var.tags
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "${var.tags["Name"]}-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.app_scale_target.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

resource "aws_ecs_service" "web_api" {
  name            = var.tags["Name"]
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.web_api.arn
  desired_count   = var.desired_tasks
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "nginx"
    container_port   = var.container_port
  }

  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web_app_ssl]
}

resource "aws_ecs_task_definition" "web_api" {
  family       = "${var.tags["Name"]}-app"
  network_mode = "bridge"
  container_definitions = templatefile("${path.module}/container_definitions/container_def.json", {
    image               = var.api_ecr_repo_url
    region              = data.aws_region.current.name
    container_name      = var.container_name
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.web_app.name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
  })

  tags = var.tags

}

