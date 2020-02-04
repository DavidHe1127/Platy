# expected module input vars
variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "lb_sg_id" {
  type        = string
  description = "load balancer sg id"
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "public_subnets" {
  type        = list
  description = "Array of minimum 2 public subnets from 2 azs"
}

variable "target_count" {
  type        = number
  description = "The number of targets to be registered"
}

variable "target_ids" {
  type        = list
  description = "List of target ids"
}

