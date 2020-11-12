resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.tags["Name"]}-instance-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_service_role" {
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role_policy_attachment" "s3_media_bucket" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = aws_iam_policy.s3_media_bucket_policy.arn
}

resource "aws_iam_policy" "s3_media_bucket_policy" {
  name        = "ecs-bucket-access-policy"
  path        = "/"
  description = "Allow access to media bucket from ECS EC2 role"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


