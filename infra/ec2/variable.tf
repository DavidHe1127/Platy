variable "names" {
  type        = list
  description = "Instance(s) names set by tag"
}

variable "subnets" {
  type        = list
  description = "Instance subnet id"
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



