variable "name" {
  type        = string
  description = "instance name"
}

variable "subnets" {
  type        = list
  description = "id of subnets where instances will be distributed across"
}

variable "ami" {
  type        = string
  description = "ami id"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ami id"
}

variable "key_name" {
  type        = string
  description = "key name"
}

variable "cluster" {
  type        = string
  description = "cluster instances to register"
}

variable "instance_attributes" {
  type        = string
  description = "instance attributes"
}

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

variable "target_group_arns" {
  type        = list
  description = "Arn of target groups to launch instances in"
}

variable "app_instance_sg_ids" {
  type        = list
  description = "multiple sg ids"
}

variable "ecs_cluster_auto_scaling_role_arn" {
  type        = string
  description = "ECS cluster auto scaling role arn"
}

variable "launch_template_name" {
  type        = string
  description = "launch template name"
}
