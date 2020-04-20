resource "aws_cloudwatch_metric_alarm" "dockerzon-service-scale-in-alarm" {
  alarm_name        = "DockerzonServiceScaleInAlarm"
  alarm_description = "Scale service in when CPUUtilization fall short of specified threshold"
  namespace         = "AWS/ECS"

  # ecs service overall cpu utilization
  metric_name         = "CPUUtilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  period              = "60"
  statistic           = "Average"
  threshold           = "25"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"

  # dimensions - an aspect or feature of a situation
  dimensions = {
    ClusterName = var.cluster
    ServiceName = var.service
  }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  # alarm_actions = [
  #   aws_autoscaling_policy.ecs-asg_decrease.arn
  # ]
}

resource "aws_cloudwatch_metric_alarm" "dockerzon-service-scale-out-alarm" {
  alarm_name        = "DockerzonServiceScaleOutAlarm"
  alarm_description = "Scale service out when CPUUtilization exceeds specified threshold"
  namespace         = "AWS/ECS"

  # ecs service overall cpu utilization
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  period              = "60"
  statistic           = "Average"
  threshold           = "75"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"

  # dimensions - an aspect or feature of a situation
  dimensions = {
    ClusterName = var.cluster
    ServiceName = var.service
  }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions = [
    aws_appautoscaling_policy.ecs-scaling-out-policy.arn
  ]
}
