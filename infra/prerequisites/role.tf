# Service-linked role
resource "aws_iam_service_linked_role" "ecs-service-auto-scaling-role" {
  aws_service_name = "autoscaling.amazonaws.com"
  description = "autoscaling role created by dockerzon terraform"
}
