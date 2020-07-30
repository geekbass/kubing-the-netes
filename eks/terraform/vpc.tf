// if availability zones is not set request the available in this region
data "aws_availability_zones" "available" {
}

locals {
  availability_zones = coalescelist(var.availability_zones, data.aws_availability_zones.available.names)
  subnet_range       = "10.0.128.0/18"
}

resource "aws_vpc" "eks" {
  cidr_block           = "10.0.128.0/18"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = map(
    "Name", "${local.cluster_name}",
    "kubernetes.io/cluster/${local.cluster_name}", "shared",
  )
}

resource "aws_subnet" "eks" {
  count = length(local.availability_zones)

  availability_zone       = element(coalescelist(local.availability_zones, data.aws_availability_zones.available.names), count.index)
  cidr_block              = cidrsubnet(local.subnet_range, 4, count.index)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.eks.id

  tags = map(
    "Name", "${local.cluster_name}",
    "kubernetes.io/cluster/${local.cluster_name}", "shared",
  )
}

resource "aws_internet_gateway" "eks" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "${local.cluster_name}"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.eks.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks.id
}
