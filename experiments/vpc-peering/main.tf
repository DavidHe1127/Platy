provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
  version = "~> 2.8"
}

terraform {
  backend "s3" {
    bucket  = "dave-dockerzon-ecs-tfstate"
    key     = "dockerzon-ecs-vpc-peering-terraform.tfstate"
    region  = "ap-southeast-2"
    # alternatively create an IAM user and attach required permissions to him. The resulting policy can then be added
    # to ACL
    profile = "qq"
  }
}

