resource "aws_security_group" "dockerzon-vpc-endpoint-sg" {
  name        = "dockerzon-vpc-endpoint-sg"
  description = "Dockerzon vpc endpoint security group"
  vpc_id      = aws_vpc.dockerzon-ecs-vpc.id

  tags = {
    Name = "dockerzon-vpc-endpoint-sg"
  }

}

resource "aws_security_group_rule" "allow-inbound-traffic-from-private-instances" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dockerzon-vpc-endpoint-sg.id
  source_security_group_id = aws_security_group.app-instance-sg.id
}
