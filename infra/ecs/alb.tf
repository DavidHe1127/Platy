resource "aws_lb_target_group" "dockerzon-lb-tg" {
  target_type = "instance"
  name        = "dockerzon-lb-tg"

  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.dockerzon-vpc.id

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

resource "aws_lb_target_group" "alb-tg-temperature-api-blue" {
  target_type = "instance"
  name        = "alb-tg-temperature-api-blue"

  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.dockerzon-vpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/health_check"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 6
  }

  tags = {
    Name = "alb-tg-temperature-api-blue"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "alb-tg-temperature-api-green" {
  target_type = "instance"
  name        = "alb-tg-temperature-api-green"

  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.dockerzon-vpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/health_check"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 6
  }

  tags = {
    Name = "alb-tg-temperature-api-green"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# listener rule
resource "aws_lb_listener_rule" "path_based_routing" {
  listener_arn = aws_lb_listener.dockerzon-lb-https-listener.arn
  priority     = 99

  action {
    type = "forward"
    # Blue/Green weighted target groups
    forward {
      target_group {
        arn    = aws_lb_target_group.alb-tg-temperature-api-blue.arn
        weight = 100
      }
      target_group {
        arn    = aws_lb_target_group.alb-tg-temperature-api-green.arn
        weight = 0
      }
      stickiness {
        enabled  = false
        duration = 600
      }
    }
  }

  condition {
    path_pattern {
      values = ["/weather"]
    }
  }
}

# alb
resource "aws_lb" "dockerzon-lb" {
  name               = "dockerzon-lb-terraform"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = data.aws_subnet_ids.dockerzon-public-subnets.ids
  security_groups    = data.aws_security_groups.alb-sg.ids

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
