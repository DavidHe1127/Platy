variable "vpc_id" {
  type        = string
  description = "vpc id sg is created in"
}

variable "alb_sg_id" {
  type        = string
  description = "alb sg id to allow inbound traffic from alb"
}
