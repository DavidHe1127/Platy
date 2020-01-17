variable "name" {
  type        = string
  description = "instance name"
}

variable "subnets" {
  type        = list
  description = "instance subnet id"
}

variable "instance_count" {
  type        = number
  description = "Instance count"
}

variable "ami" {
  type        = string
  description = "ami id"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "alb_sg_id" {
  type        = string
  description = "alb sg id"
}



