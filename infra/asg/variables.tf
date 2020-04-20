variable "cluster" {
  type        = string
  description = "ECS cluster name"
}

variable "service" {
  type        = string
  description = "ECS service name"
}

variable "ecs_auto_scale_role_arn" {
  type = string
  description = "ECS auto scale role arn"
}
