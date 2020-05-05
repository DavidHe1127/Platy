resource "aws_iam_service_linked_role" "ecs-app-auto-scaling-role" {
  aws_service_name = "ecs.application-autoscaling.amazonaws.com"
}

resource "aws_iam_role_policy_attachment" "policy-attachment" {
  role       = aws_iam_service_linked_role.ecs-app-auto-scaling-role.name
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingECSServicePolicy"
}
