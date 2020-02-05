resource "aws_lb_target_group" "dockerzon-lb-tg" {
  target_type = "instance"
  name        = "dockerzon-lb-tg"

  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/health_check"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 6
  }

  tags = {
    Name = "dockerzon-lb-tg-terraform"
  }
}

# alb
resource "aws_lb" "dockerzon-lb" {
  name               = "dockerzon-lb-terraform"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"

  subnets         = var.public_subnets
  security_groups = [var.lb_sg_id]

  tags = {
    Name = "dockerzon-lb-terraform"
  }
}

# alb listener
resource "aws_lb_listener" "dockerzon-lb-listner" {
  load_balancer_arn = aws_lb.dockerzon-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dockerzon-lb-tg.arn
  }
}

# attach targets to target group
# NOT REQUIRED when using it with ecs. ECS will automatically do attachment
# resource "aws_lb_target_group_attachment" "dockerzon-lb-tg-attachment" {
#   count            = var.target_count
#   target_group_arn = aws_lb_target_group.dockerzon-lb-tg.arn
#   port             = 80
#   target_id        = element(var.target_ids, count.index)
# }
