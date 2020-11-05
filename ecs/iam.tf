# Cluster Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.tags["name"]}-ecs_task_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  # file("${path.module}/policies/ecs-task-execution-role.json")
}

# Cluster Execution Policy
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${var.tags["name"]}-role-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
  role   = aws_iam_role.ecs_execution_role.id
  # file("${path.module}/policies/ecs-execution-role-policy.json")
}

# resource "aws_iam_role" "ecs_service_role" {
#   name               = "${var.cluster_name}-ecs_role"
#   assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
# }

# resource "aws_iam_role_policy" "ecs_service_role_policy" {
#   name   = "${var.cluster_name}_role_policy"
#   policy = data.aws_iam_policy_document.ecs_service_policy.json
#   role   = aws_iam_role.ecs_role.id
# }

# # ECS Service Policy
# data "aws_iam_policy_document" "ecs_service_policy" {
#   statement {
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "elasticloadbalancing:Describe*",
#       "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#       "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#       "ec2:Describe*",
#       "ec2:AuthorizeSecurityGroupIngress",
#     ]
#   }
# }

# # ECS Service Policy
# data "aws_iam_policy_document" "ecs_service_role" {
#   statement {
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs.amazonaws.com"]
#     }
#   }
# }

