# Modules that allows creating a subnet inside a VPC. This module can be used to create either a private or public-facing subnet

resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.cidrs)
  map_public_ip_on_launch = var.public_ip ? true : false

  tags = {
    name        = "${var.name}_${element(var.availability_zones, count.index)}"
    environment = lookup(var.tags, "environment", "production")
  }
}

resource "aws_route_table" "subnet" {
  vpc_id = var.vpc_id
  count  = length(var.cidrs)

  tags = {
    name        = "${var.name}_${element(var.availability_zones, count.index)}"
    environment = lookup(var.tags, "environment", "production")
  }
}

resource "aws_route_table_association" "subnet" {
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element(aws_route_table.subnet.*.id, count.index)
  count          = length(var.cidrs)
}
