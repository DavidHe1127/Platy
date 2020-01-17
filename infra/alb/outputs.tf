output "alb_target_group" {
  value = aws_lb_target_group.dockerzon-ecs-target-group.id
}

output "sg_id" {
  value = aws_security_group.dockerzon-alb-sg.id
}
