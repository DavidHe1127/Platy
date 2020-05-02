locals {
  configs = {
    ec2 = {
      # ecs ami ami-06862a6ef1260bb02
      # ec2 ami ami-086be9e7a208dad05
      ami                  = "ami-06862a6ef1260bb02"
      name                 = "dockerzon-ecs-instance"
      subnets              = [var.vpc_public_subnets["2a"], var.vpc_public_subnets["2b"]]
      instance_attributes  = "{\\\"app\\\": \\\"dockerzon\\\"}"
      vpc_id               = var.vpc_id
      cluster              = var.cluster
      key_name             = "dockerzon-ecs"
      launch_template_name = "dockerzon"

      # asg
      target_group_arns                 = ["arn:aws:elasticloadbalancing:ap-southeast-2:216659404274:targetgroup/dockerzon-lb-tg-temperature-api/2d4b1d8787f53df7"]
      app_instance_sg_ids               = [var.app_sg_id]
      ecs_cluster_auto_scaling_role_arn = "arn:aws:iam::216659404274:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
    }
  }
}
