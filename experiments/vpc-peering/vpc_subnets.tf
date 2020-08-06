# public vpc
resource "aws_vpc" "vpc-peering-public-vpc" {
  cidr_block = "10.100.0.0/16"
  # dns settings below required to use VPC PrviateLinks
  # enable_dns_support   = true
  # enable_dns_hostnames = true

  tags = {
    env  = "dev"
    purpose  = "vpc-peering"
    Name = "vpc-peering-public-vpc"
  }
}

resource "aws_subnet" "pub-vpc-private-subnet-2c" {
  vpc_id                  = aws_vpc.vpc-peering-public-vpc.id
  cidr_block              = "10.100.1.0/24"
  availability_zone       = "ap-southeast-2c"

  tags = {
    Name = "10.100.1.0/ap-southeast-2c/private"
    Tier = "private"
  }
}

resource "aws_subnet" "pub-vpc-public-subnet-2b" {
  vpc_id                  = aws_vpc.vpc-peering-public-vpc.id
  cidr_block              = "10.100.0.0/24"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.100.0.0/ap-southeast-2b/public"
    Tier = "public"
  }
}

# IGW
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc-peering-public-vpc.id

  tags = {
    Name = "vpc-peering-igw"
  }
}

# Route Table
# default route mapping vpc's cidr to local to allow communication
# between subnets is created implicitly and cannot be explicitly specified
resource "aws_route_table" "vpc-peering-public-route" {
  vpc_id = aws_vpc.vpc-peering-public-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.vpc-igw.id
  }

  tags = {
    Name = "vpc-peering-public-route"
  }
}

# Route Table association
resource "aws_route_table_association" "public-subnet-2b-route-link" {
  subnet_id      = aws_subnet.pub-vpc-public-subnet-2b.id
  route_table_id = aws_route_table.vpc-peering-public-route.id
}

# private vpc
resource "aws_vpc" "vpc-peering-private-vpc" {
  cidr_block = "10.200.0.0/16"

  tags = {
    env  = "dev"
    purpose  = "vpc-peering"
    Name = "vpc-peering-private-vpc"
  }
}

resource "aws_subnet" "pri-vpc-private-subnet-2c" {
  vpc_id                  = aws_vpc.vpc-peering-private-vpc.id
  cidr_block              = "10.200.0.0/24"
  availability_zone       = "ap-southeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.200.0.0/ap-southeast-2c/private"
    Tier = "private"
  }
}
