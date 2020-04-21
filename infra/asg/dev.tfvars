cluster                 = "dockerzon"
service                 = "temperature-api"
# service auto scaling refers to application auto scaling
ecs_service_auto_scaling_role_arn = "arn:aws:iam::216659404274:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
ecs_cluster_auto_scaling_role_arn = "arn:aws:iam::216659404274:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
vpc_public_subnets = {
  "2a" = "subnet-0d01e5855712bc5c1"
  "2b" = "subnet-09d6e839d44e7ea34"
}

target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-2:216659404274:targetgroup/dockerzon-lb-tg-temperature-api/2d4b1d8787f53df7"
