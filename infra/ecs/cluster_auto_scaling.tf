resource "aws_ecs_capacity_provider" "dockerzon-cas" {
  name = "dockerzon-cas"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = data.aws_autoscaling_group.dockerzon-cluster-asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 50
    }
  }

  tags = {
    Owner = "ECS"
  }
}
