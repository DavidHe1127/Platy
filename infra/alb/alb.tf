# alb lab 10:33
variable "vpc_tag_name" {}

data "aws_vpc" "dockerzon-ecs-vpc" {
  tags = {
    Name = "${var.vpc_tag_name}"
  }
}

provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

resource "aws_lb_target_group" "dockerzon-ecs-target-group" {
  target_type = "instance"

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
