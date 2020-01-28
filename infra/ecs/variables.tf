# expected input vars
variable "vpc_tag_name" {
  type        = string
  description = "vpc name tag"
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
