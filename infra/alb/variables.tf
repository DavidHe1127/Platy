# expected module input vars
variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "public_subnets" {
  type        = list
  description = "Array of minimum 2 public subnets from 2 azs"
}

variable "security_groups" {
  type        = list
  description = "Array of security groups"
}

variable "target_count" {
  type        = number
  description = "Target length"
}

variable "target_arns" {
  type        = list
  description = "List of target arn"
}

