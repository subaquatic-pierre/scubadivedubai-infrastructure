resource "aws_autoscaling_group" "app_scale_target" {
  name                 = var.tags["name"]
  vpc_zone_identifier  = var.subnet_ids
  min_size             = var.min_tasks
  max_size             = var.max_tasks
  desired_capacity     = var.desired_tasks
  launch_configuration = aws_launch_configuration.app.name
}

// Trocar aqui
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${var.tags["name"]}-CPU-Utilization-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.cpu_to_scale_up

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.web_api.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_up.arn]
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = "${var.tags["name"]}-app-scale-up"
  service_namespace  = aws_autoscaling_group.app_scale_target.name
  resource_id        = aws_autoscaling_group.app_scale_target.id
  scalable_dimension = aws_autoscaling_group.app_scale_target.desired_capacity

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${var.tags["name"]}-CPU-Utilization-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.cpu_to_scale_down

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.web_api.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_down.arn]
}

resource "aws_appautoscaling_policy" "app_down" {
  name               = "${var.tags["name"]}-scale-down"
  service_namespace  = aws_autoscaling_group.app_scale_target.name
  resource_id        = aws_autoscaling_group.app_scale_target.id
  scalable_dimension = aws_autoscaling_group.app_scale_target.desired_capacity

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

