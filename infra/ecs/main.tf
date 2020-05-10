provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket  = "dave-dockerzon-ecs-tfstate"
    key     = "dockerzon-ecs-ecs-terraform.tfstate"
    region  = "ap-southeast-2"
    # alternatively create an IAM user and attach required permissions to him. The resulting policy can then be added
    # to ACL
    profile = "qq"
  }
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
