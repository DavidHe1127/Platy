# expected input vars
variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "app_name" {
  type        = string
  description = "app name"
}

variable "domain_name" {
  type        = string
  description = "Full qualified domain name"
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
