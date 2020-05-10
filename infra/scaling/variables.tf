variable "cluster" {
  type        = string
  description = "ECS cluster name"
}

variable "service" {
  type        = string
  description = "ECS service name"
}

variable "ecs_state_file_key" {
  type = string
  default = "dockerzon-ecs-ecs-terraform.tfstate"
  description = "ECS state file key"
}
