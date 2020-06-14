data "aws_vpc" "dockerzon-vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet_ids" "dockerzon-public-subnets" {
  vpc_id = data.aws_vpc.dockerzon-vpc.id

  tags = {
    Tier = "public"
  }
}

data "aws_subnet_ids" "dockerzon-private-subnets" {
  vpc_id = data.aws_vpc.dockerzon-vpc.id

  tags = {
    Tier = "private"
  }
}

data "aws_acm_certificate" "https-cert" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

data "aws_security_groups" "app-sg" {
  filter {
    name   = "tag:Name"
    values = ["app-instance-sg-terraform"]
  }
}

data "aws_security_groups" "alb-sg" {
  filter {
    name   = "tag:Name"
    values = ["dockerzon-lb-sg-terraform"]
  }
}

data "terraform_remote_state" "prerequisites-state" {
  backend = "s3"

  config = {
    bucket  = "dave-dockerzon-ecs-tfstate"
    key     = var.prerequisites_state_file_key
    region  = "ap-southeast-2"
    profile = "qq"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy" "task-exec-role-policy-aws" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
