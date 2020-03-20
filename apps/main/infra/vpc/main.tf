provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

locals {
  region = "ap-southeast-2"
}

# subnets
resource "aws_subnet" "public-subnet-2a" {
  vpc_id                  = aws_vpc.dockerzon-ecs-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.0.1.0/ap-southeast-2a/public"
  }
}

resource "aws_subnet" "public-subnet-2b" {
  vpc_id                  = aws_vpc.dockerzon-ecs-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.0.3.0/ap-southeast-2b/public"
  }
}

resource "aws_subnet" "private-subnet-2a" {
  vpc_id            = aws_vpc.dockerzon-ecs-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "10.0.5.0/ap-southeast-2a/private"
  }
}

resource "aws_subnet" "private-subnet-2b" {
  vpc_id            = aws_vpc.dockerzon-ecs-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "10.0.4.0/ap-southeast-2b/private"
  }
}

# vpc
resource "aws_vpc" "dockerzon-ecs-vpc" {
  cidr_block = "10.0.0.0/16"
  # dns settings below required to use VPC PrviateLinks
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    env  = "dev"
    app  = "dockerzon-ecs"
    Name = var.name
  }
}

# IGW
resource "aws_internet_gateway" "dockerzon-ecs-vpc-igw" {
  vpc_id = aws_vpc.dockerzon-ecs-vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# Route Table
# default route mapping vpc's cidr to local to allow communication
# between subnets is created implicitly and cannot be specified
resource "aws_route_table" "dockerzon-ecs-vpc-public-route" {
  vpc_id = aws_vpc.dockerzon-ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dockerzon-ecs-vpc-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.dockerzon-ecs-vpc-igw.id
  }

  tags = {
    Name = "${var.name}-public-route"
  }
}

# Route Table association
resource "aws_route_table_association" "public-subnet-2a-route-link" {
  subnet_id      = aws_subnet.public-subnet-2a.id
  route_table_id = aws_route_table.dockerzon-ecs-vpc-public-route.id
}

resource "aws_route_table_association" "public-subnet-2b-route-link" {
  subnet_id      = aws_subnet.public-subnet-2b.id
  route_table_id = aws_route_table.dockerzon-ecs-vpc-public-route.id
}
