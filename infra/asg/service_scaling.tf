# target is ecs task in the service
resource "aws_appautoscaling_target" "ecs-service-auto-scaling-target" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/${var.cluster}/${var.service}"
  role_arn           = var.ecs_auto_scale_role_arn
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs-scaling-out-policy" {
  name               = "DockerzonServiceScaleOutPolicy"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs-service-auto-scaling-target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs-service-auto-scaling-target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs-service-auto-scaling-target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type          = "PercentChangeInCapacity"
    cooldown                 = 300
    metric_aggregation_type  = "Average"
    min_adjustment_magnitude = 1

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = "" # indicates infinity
      scaling_adjustment          = 100
    }
  }
}
