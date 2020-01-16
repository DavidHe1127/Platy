# expected input vars
variable "vpc_tag_name" {
  type        = string
  description = "vpc name tag"
}

variable "ami" {
  type        = string
  description = "custom ami with apache pre-installed"
}
