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

variable "target_group_arns" {
  type        = list
  description = "Arn of target groups to launch instances in"
}

# launch template
variable "ami" {
  type        = string
  default     = "ami-06862a6ef1260bb02"
  description = "AMI id new instance is launched from"
}

variable "instance" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}

variable "key" {
  type        = string
  description = "Key for ssh"
}

variable "vpc_security_group_ids" {
  type        = list
  description = "vpc sg ids"
}

variable "app_instance_sg_ids" {
  type        = list
  description = "app instance sg ids"
}

variable "instance_profile" {
  type        = string
  description = "instance profile name"
}

# asg
variable "min_size_asg" {
  type        = number
  default     = 1
  description = "Min asg size"
}

variable "max_size_asg" {
  type        = number
  default     = 3
  description = "Max asg size"
}

variable "desired_capacity_asg" {
  type        = number
  default     = 1
  description = "Desired count of targets"
}
