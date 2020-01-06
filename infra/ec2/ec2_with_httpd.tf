# 8:45 for alb on aws cert course
provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

resource "aws_instance" "web" {
  ami             = "ami-0119aa4d67e59007c"
  instance_type   = "t2.micro"
  key_name        = "test-terraform-vpc-provisioning"
  user_data       = templatefile("ec2/install_apache.sh", { server = "01" })
  security_groups = [aws_security_group.terraform-web-sg.name]

  tags = {
    Name = "terraform-web01"
  }
}

resource "aws_security_group" "terraform-web-sg" {
  name        = "terraform-web-sg"
  description = "Terraform experiment"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
