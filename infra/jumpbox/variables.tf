variable "public_subnet_id" {
  type        = string
  description = "public subnet id"
}

variable "ssh_key" {
  type        = string
  description = "ssh key name"
}

variable "private_subnet_cidr" {
  type        = string
  description = "private subnet cidr"
}
