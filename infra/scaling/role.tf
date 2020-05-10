resource "aws_iam_service_linked_role" "ecs-app-auto-scaling-role" {
  aws_service_name = "ecs.application-autoscaling.amazonaws.com"
  description      = "app autoscaling role created by terraform"
}
