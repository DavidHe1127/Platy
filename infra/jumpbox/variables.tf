variable "key_name" {
  type        = string
  description = "ssh key name"
}

variable "ami" {
  type        = string
  description = "jump box ami"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "hosting_subnet_id" {
  type        = string
  description = "id of public subnet where jump box is hosted"
}
