# for vpc/subnets
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

# container instance
module "instances" {
  source = "./ec2"

  instance_count = 2
  name           = var.app_name
  subnets        = [aws_subnet.private-subnet-2a.id, aws_subnet.private-subnet-2b.id]
  ami            = var.ami
  vpc_id         = aws_vpc.dockerzon-ecs-vpc.id
  alb_sg_id      = module.alb.sg_id
  cluster        = var.cluster
  key_name       = var.instance_key_name
}

# modules
module "alb" {
  source = "./alb"

  vpc_id         = aws_vpc.dockerzon-ecs-vpc.id
  vpc_name       = var.vpc_tag_name
  public_subnets = [aws_subnet.public-subnet-2a.id, aws_subnet.public-subnet-2b.id]
  target_count   = 2
  target_ids     = module.instances.instance_ids
  app_sg_id      = module.instances.app_sg_id
}
