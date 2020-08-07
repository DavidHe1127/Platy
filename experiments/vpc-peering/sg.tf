# requester vpc ec2 sg
resource "aws_security_group" "requester-vpc-ec2-sg" {
  vpc_id      = aws_vpc.requester-vpc.id

  tags = {
    Name = "vpc-peering-requester-vpc-ec2-sg"
  }
}

// this allow instances within the same subnet talk to each other
resource "aws_security_group_rule" "requester-vpc-http-in" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.requester-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "requester-vpc-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.requester-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "requester-vpc-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.requester-vpc-ec2-sg.id
}

# accepter vpc ec2 sg
resource "aws_security_group" "accepter-vpc-ec2-sg" {
  vpc_id      = aws_vpc.accepter-vpc.id

  tags = {
    Name = "vpc-peering-accepter-vpc-ec2-sg"
  }
}

// this allow instances within the same subnet talk to each other
resource "aws_security_group_rule" "accepter-vpc-http-in" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.accepter-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "accepter-vpc-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.accepter-vpc-ec2-sg.id
}

resource "aws_security_group_rule" "accepter-vpc-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.accepter-vpc-ec2-sg.id
}
