# requester vpc
resource "aws_vpc" "requester-vpc" {
  cidr_block = "10.100.0.0/16"
  # dns settings below required to use VPC PrviateLinks
  # enable_dns_support   = true
  # enable_dns_hostnames = true

  tags = {
    env     = "dev"
    purpose = "vpc-peering"
    Name    = "requester-vpc"
  }
}

resource "aws_subnet" "requester-vpc-public-subnet-2b" {
  vpc_id                  = aws_vpc.requester-vpc.id
  cidr_block              = "10.100.0.0/24"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "10.100.0.0/ap-southeast-2b/public"
    Tier = "requester-vpc"
  }
}

resource "aws_subnet" "requester-vpc-private-subnet-2c" {
  vpc_id            = aws_vpc.requester-vpc.id
  cidr_block        = "10.100.1.0/24"
  availability_zone = "ap-southeast-2c"

  tags = {
    Name = "10.100.1.0/ap-southeast-2c/private"
    Tier = "requester-vpc"
  }
}

# IGW
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.requester-vpc.id

  tags = {
    Name = "vpc-peering-igw"
  }
}

# Route Table
# default route mapping vpc's cidr to local to allow communication
# between subnets is created implicitly and cannot be explicitly specified
resource "aws_route_table" "requester-vpc-pub-subnet-route-table" {
  vpc_id = aws_vpc.requester-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.vpc-igw.id
  }

  tags = {
    Purpose = "vpc-peering"
    Name    = "requester-vpc-pub-subnet-route-table"
  }
}

resource "aws_route_table_association" "public-subnet-2b-route-link" {
  subnet_id      = aws_subnet.requester-vpc-public-subnet-2b.id
  route_table_id = aws_route_table.requester-vpc-pub-subnet-route-table.id
}

resource "aws_route_table" "requester-vpc-pri-subnet-route-table" {
  vpc_id = aws_vpc.requester-vpc.id

  route {
    cidr_block                = aws_subnet.accepter-vpc-private-subnet-2c.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering-requester.id
  }

  tags = {
    Purpose = "vpc-peering"
    Name    = "requester-vpc-pri-subnet-route-table"
  }
}

resource "aws_route_table_association" "requester-vpc-pri-subnet-route-table-link" {
  subnet_id      = aws_subnet.requester-vpc-private-subnet-2c.id
  route_table_id = aws_route_table.requester-vpc-pri-subnet-route-table.id
}

################################### accepter vpc #######################################################
resource "aws_vpc" "accepter-vpc" {
  cidr_block = "10.200.0.0/16"
  # provider   = aws.peer

  tags = {
    env     = "dev"
    purpose = "vpc-peering"
    Name    = "accepter-vpc"
  }
}

resource "aws_subnet" "accepter-vpc-private-subnet-2c" {
  vpc_id                  = aws_vpc.accepter-vpc.id
  cidr_block              = "10.200.0.0/24"
  availability_zone       = "ap-southeast-2c"

  tags = {
    Name = "10.200.0.0/ap-southeast-2c/private"
    Tier = "accepter-subnet"
  }
}

resource "aws_route_table" "accepter-vpc-pri-subnet-route-table" {
  vpc_id = aws_vpc.accepter-vpc.id

  route {
    cidr_block                = aws_subnet.requester-vpc-private-subnet-2c.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering-requester.id
  }

  tags = {
    Name    = "accepter-vpc-pri-subnet-route-table"
    Purpose = "vpc-peering"
  }
}

# Route Table association
resource "aws_route_table_association" "accepter-vpc-pri-subnet-2c-route-table-link" {
  subnet_id      = aws_subnet.accepter-vpc-private-subnet-2c.id
  route_table_id = aws_route_table.accepter-vpc-pri-subnet-route-table.id
}
