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

variable "app_sg_id" {
  type        = string
  description = "instance sg id"
}

variable "key_name" {
  type        = string
  description = "key name"
}

variable "cluster" {
  type        = string
  description = "cluster instances to register"
}

