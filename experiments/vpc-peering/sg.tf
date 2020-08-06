# public vpc ec2 sg
resource "aws_security_group" "pub-vpc-ec2-sg" {
  vpc_id      = aws_vpc.vpc-peering-public-vpc.id

  tags = {
    Name = "vpc-peering-pub-vpc-ec2-sg"
  }
}

// this allow instances within the same subnet talk to each other
resource "aws_security_group_rule" "pub-vpc-http-in" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.pub-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "pub-vpc-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "pub-vpc-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-vpc-ec2-sg.id
}

# private vpc ec2 sg
resource "aws_security_group" "pri-vpc-ec2-sg" {
  vpc_id      = aws_vpc.vpc-peering-private-vpc.id

  tags = {
    Name = "vpc-peering-pri-vpc-ec2-sg"
  }
}

// this allow instances within the same subnet talk to each other
resource "aws_security_group_rule" "pri-vpc-http-in" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.pri-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "pri-vpc-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pri-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "pri-vpc-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pri-vpc-ec2-sg.id
}
