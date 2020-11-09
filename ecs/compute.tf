data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "app" {
  security_groups = [
    aws_security_group.app_sg.id,
  ]

  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.app.name
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }

  user_data = templatefile("${path.module}/launchconfig_userdata.sh", {
    ECS_CLUSTER = aws_ecs_cluster.cluster.name
  })
}
