variable "cluster" {
  type        = string
  description = "ECS cluster name"
}

variable "service" {
  type        = string
  description = "ECS service name"
}

variable "ecs_service_auto_scaling_role_arn" {
  type        = string
  description = "ECS service auto scaling role arn"
}

variable "ecs_cluster_auto_scaling_role_arn" {
  type        = string
  description = "ECS cluster auto scaling role arn. Cluster scaling is achieved through EC2 ASG"
}

variable "vpc_public_subnets" {
  type        = map
  description = "VPC public subnets id"
}

variable "target_group_arn" {
  type        = string
  description = "Arn of target group to launch instances in"
}
