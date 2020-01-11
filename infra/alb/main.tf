# alb lab 10:33
data "aws_vpc" "dockerzon-ecs-vpc" {
  tags = {
    Name = var.vpc_tag_name
  }
}

resource "aws_lb_target_group" "dockerzon-ecs-target-group" {
  target_type = "instance"
  name        = var.vpc_tag_name

  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.dockerzon-ecs-vpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/index.html"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 6
  }

  tags = {
    Name = "dockerzon-ecs"
  }
}
