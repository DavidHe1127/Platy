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

  ami                               = local.configs.ec2.ami
  name                              = local.configs.ec2.name
  subnets                           = local.configs.ec2.subnets
  cluster                           = local.configs.ec2.cluster
  key_name                          = local.configs.ec2.key_name
  target_group_arns                 = local.configs.ec2.target_group_arns
  app_instance_sg_ids               = local.configs.ec2.app_instance_sg_ids
  instance_attributes               = local.configs.ec2.instance_attributes
  launch_template_name              = local.configs.ec2.launch_template_name
  ecs_cluster_auto_scaling_role_arn = local.configs.ec2.ecs_cluster_auto_scaling_role_arn
}

# load balancer
module "alb" {
  source = "./alb"

  vpc_id         = var.vpc_id
  vpc_name       = var.vpc_name
  public_subnets = [var.vpc_public_subnets["2a"], var.vpc_public_subnets["2b"]]
  target_count   = 2
  lb_sg_id       = var.lb_sg_id
  domain_name    = var.domain_name
}
