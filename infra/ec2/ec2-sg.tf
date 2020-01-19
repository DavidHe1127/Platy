resource "aws_security_group" "app-instance-sg" {
  name        = "app-instance-sg-terraform"
  description = "Flow traffic to alb"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = [var.alb_sg_id]
  }

  tags = {
    Name = "app-instance-sg-terraform"
  }
}
