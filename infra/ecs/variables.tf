# expected input vars
variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "vpc_public_subnets" {
  type        = map
  description = "vpc public subnet map"
}

variable "vpc_private_subnets" {
  type        = map
  description = "vpc private subnet map"
}

variable "ami" {
  type        = string
  description = "custom ami with apache pre-installed"
}

variable "app_name" {
  type        = string
  description = "app name"
}

variable "cluster" {
  type        = string
  description = "ecs cluster"
}

variable "instance_key_name" {
  type        = string
  description = "instance key name"
}

variable "app_sg_id" {
  type        = string
  description = "instance sg id"
}

variable "lb_sg_id" {
  type        = string
  description = "load balancer sg id"
}
