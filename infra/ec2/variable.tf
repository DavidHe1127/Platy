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

variable "security_groups" {
  type        = list
  description = "Instance security groups"
}
