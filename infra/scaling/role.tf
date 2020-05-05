resource "aws_iam_role" "app-auto-scaling-service-role" {
  name                  = "AWSServiceRoleForApplicationAutoScaling_ECSService"
  assume_role_policy    = file("configs/assumer_role_policy.json")
  force_detach_policies = true

  tags = {
    Purpose = "Application auto scaling service role"
  }
}

resource "aws_iam_role_policy_attachment" "policy-attachment" {
  role       = aws_iam_role.app-auto-scaling-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingECSServicePolicy"
}

