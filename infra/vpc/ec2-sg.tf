resource "aws_security_group" "app-instance-sg" {
  name        = "app-instance-sg-terraform"
  description = "Flow traffic to alb"
  vpc_id      = aws_vpc.dockerzon-ecs-vpc.id

  tags = {
    Name = "app-instance-sg-terraform"
  }
}

resource "aws_security_group_rule" "allow-inbound-traffic-from-alb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.dockerzon-lb-sg.id
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
  security_group_id = aws_security_group.app-instance-sg.id
}

