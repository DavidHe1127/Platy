provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

resource "aws_instance" "dockerzon-jumpbox" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.dockerzon-jumpbox-sg.id]

  subnet_id = var.hosting_subnet_id

  tags = {
    Name = "dockerzon-ecs-jumpbox"
  }
}

resource "aws_security_group" "dockerzon-jumpbox-sg" {
  name        = "dockerzon-jumpbox-sg"
  description = "Allow login to private instance through jumpbox"
  vpc_id      = var.vpc_id

  tags = {
    Name = "dockerzon-jumpbox-sg"
  }
}

resource "aws_security_group_rule" "allow-ssh-from-anywhere" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dockerzon-jumpbox-sg.id
}
