resource "aws_autoscaling_group" "dockerzon-cluster-asg" {
  name                      = "DockerzonClusterASG"
  max_size                  = 3
  min_size                  = 0
  desired_capacity          = 0
  vpc_zone_identifier       = [var.vpc_public_subnets["2a"], var.vpc_public_subnets["2b"]]
  target_group_arns         = var.target_group_arns
  health_check_type         = "EC2"
  health_check_grace_period = 301
  service_linked_role_arn   = var.ecs_cluster_auto_scaling_role_arn

  launch_template {
    id      = aws_launch_template.dockerzon-asg.id
    version = "$Latest"
  }
}

# Remove 50% of container instances in asg when -Infinity < CPUUtilization <= 25
resource "aws_autoscaling_policy" "dockerzon-cluster-scale-in-policy" {
  name                   = "dockerzon-cluster-scale-in-policy"
  adjustment_type        = "PercentChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.dockerzon-cluster-asg.name

  policy_type             = "StepScaling"
  metric_aggregation_type = "Average"

  step_adjustment {
    metric_interval_lower_bound = ""
    metric_interval_upper_bound = 0
    scaling_adjustment          = -50
  }
}

# Add 100% of container instances in asg when 90 <= CPUUtilization < +Infinity
resource "aws_autoscaling_policy" "dockerzon-cluster-scale-out-policy" {
  name                   = "dockerzon-cluster-scale-out-policy"
  adjustment_type        = "PercentChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.dockerzon-cluster-asg.name

  policy_type             = "StepScaling"
  metric_aggregation_type = "Average"

  step_adjustment {
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = ""
    scaling_adjustment          = 100
  }
}

