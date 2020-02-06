resource "aws_security_group" "dockerzon-lb-sg" {
  name        = "dockerzon-lb-sg"
  description = "Dockerzon load balancer security group"
  vpc_id      = aws_vpc.dockerzon-ecs-vpc.id

  tags = {
    Name = "dockerzon-lb-sg-terraform"
  }

}

resource "aws_security_group_rule" "allow-outbound-traffic-to-instance" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.app-instance-sg.id
  security_group_id        = aws_security_group.dockerzon-lb-sg.id
}

resource "aws_security_group_rule" "allow-inbound-traffic" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.dockerzon-lb-sg.id
}


