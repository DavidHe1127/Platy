resource "aws_security_group" "dockerzon-lb-sg" {
  name        = "dockerzon-lb-sg"
  description = "Dockerzon load balancer security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "dockerzon-lb-sg-terraform"
  }
}

resource "aws_security_group_rule" "allow-traffic-in" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.app_sg_id
  security_group_id        = aws_security_group.dockerzon-lb-sg.id
}


resource "aws_security_group_rule" "allow-traffic-out-to-instance" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.dockerzon-lb-sg.id
}


