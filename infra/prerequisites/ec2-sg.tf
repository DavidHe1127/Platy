resource "aws_security_group" "app-instance-sg" {
  name        = "app-instance-sg-terraform"
  description = "Flow traffic to alb"
  vpc_id      = aws_vpc.dockerzon-ecs-vpc.id

  tags = {
    Name = "app-instance-sg-terraform"
  }
}

# Use port range 32768-65535 when dynamic port mapping is enabled
resource "aws_security_group_rule" "allow-inbound-traffic-from-alb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.dockerzon-lb-sg.id
  security_group_id        = aws_security_group.app-instance-sg.id
}

// this allow instances within the same subnet talk to each other
resource "aws_security_group_rule" "allow-comms-between-instances" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app-instance-sg.id
  security_group_id        = aws_security_group.app-instance-sg.id
}

resource "aws_security_group_rule" "allow-outbound-traffic-off-instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-instance-sg.id
}

resource "aws_security_group_rule" "allow-ssh-from-anywhere" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-instance-sg.id
}

