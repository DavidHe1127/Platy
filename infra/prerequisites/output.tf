output "autoscaling-service-linked-role-arn" {
  value       = aws_iam_service_linked_role.ecs-service-auto-scaling-role.arn
  description = "exported autoscaling service linked role arn"
}
