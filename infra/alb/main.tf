resource "aws_lb_target_group" "dockerzon-ecs-target-group" {
  target_type = "instance"
  name        = "dockerzon-ecs-lb-tg"

  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

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

resource "aws_lb" "dockerzon-ecs-alb" {
  name               = "dockerzon-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"

  subnets         = var.public_subnets
  security_groups = [aws_security_group.dockerzon-alb-sg.id]

  tags = {
    Name = "dockerzon-ecs-alb"
  }
}

resource "aws_lb_listener" "dockerzon-ecs-alb-listner" {
  load_balancer_arn = aws_lb.dockerzon-ecs-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dockerzon-ecs-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "dockerzon-ecs-alb-tg-attachment" {
  count            = var.target_count
  target_group_arn = aws_lb_target_group.dockerzon-ecs-target-group.arn
  port             = 80
  target_id        = element(var.target_ids, count.index)
}
