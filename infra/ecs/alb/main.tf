data "aws_acm_certificate" "https-cert" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

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

# temperature api tg
resource "aws_lb_target_group" "dockerzon-lb-tg-temperature-api" {
  target_type = "instance"
  name        = "dockerzon-lb-tg-temperature-api"

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
    Name = "dockerzon-lb-tg-temperature-api"
  }
}

# listener rule
resource "aws_lb_listener_rule" "path_based_routing" {
  listener_arn = aws_lb_listener.dockerzon-lb-https-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dockerzon-lb-tg-temperature-api.arn
  }

  condition {
    path_pattern {
      values = ["/weather/*"]
    }
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

# http listener
resource "aws_lb_listener" "dockerzon-lb-http-listener" {
  load_balancer_arn = aws_lb.dockerzon-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# https listener
resource "aws_lb_listener" "dockerzon-lb-https-listener" {
  load_balancer_arn = aws_lb.dockerzon-lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.https-cert.arn

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
