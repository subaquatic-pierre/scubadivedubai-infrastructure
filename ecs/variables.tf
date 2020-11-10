variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
}

variable "tags" {}
variable "azs" {}
variable "public_subnets" {}
variable "cidr" {}
variable "availability_zones" {}
variable "ssl_cert_arn" {}
variable "vpc_id" {}
variable "subnet_ids" {}
