resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = var.tags
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}
