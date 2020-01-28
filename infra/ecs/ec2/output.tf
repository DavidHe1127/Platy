# * splat operator
output "instance_ids" {
  value = aws_instance.web[*].id
}

output "app_sg_id" {
  value = aws_security_group.app-instance-sg.id
}
