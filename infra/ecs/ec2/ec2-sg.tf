resource "aws_security_group" "app-instance-sg" {
  name        = "app-instance-sg-terraform"
  description = "Flow traffic to alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "app-instance-sg-terraform"
  }
}

resource "aws_security_group_rule" "allow-traffic-from-alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.alb_sg_id
  ipv6_cidr_blocks         = ["::/0"]
  security_group_id        = aws_security_group.app-instance-sg.id
}

