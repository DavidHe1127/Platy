provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

# cluster
resource "aws_ecs_cluster" "dockerzon" {
  name = var.cluster

  tags = {
    Name = "dockerzon-cluster"
  }
}

# ecr repo
resource "aws_ecr_repository" "dockerzon-express" {
  name = "${var.cluster}-express"

  tags = {
    Name = "dockerzon-express-ecr-repo"
  }
}

resource "aws_ecr_repository" "dockerzon-nginx" {
  name = "${var.cluster}-nginx"

  tags = {
    Name = "dockerzon-nginx-ecr-repo"
  }
}

resource "aws_ecr_repository" "dockerzon-temperature-api" {
  name = "${var.cluster}-temperature-api"

  tags = {
    Name = "dockerzon-temperature-api-ecr-repo"
  }
}

# container instance
module "instances" {
  source = "./ec2"

  instance_count = 2
  name           = var.app_name
  subnets        = [var.vpc_public_subnets["2a"], var.vpc_public_subnets["2b"]]
  attributes     = var.instance_attributes
  ami            = var.ami
  vpc_id         = var.vpc_id
  app_sg_id      = var.app_sg_id
  cluster        = var.cluster
  key_name       = var.instance_key_name
}

# load balancer
module "alb" {
  source = "./alb"

  vpc_id         = var.vpc_id
  vpc_name       = var.vpc_name
  public_subnets = [var.vpc_public_subnets["2a"], var.vpc_public_subnets["2b"]]
  target_count   = 2
  target_ids     = module.instances.instance_ids
  lb_sg_id       = var.lb_sg_id
  domain_name    = var.domain_name
}
