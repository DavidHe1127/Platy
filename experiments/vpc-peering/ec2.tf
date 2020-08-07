# requester vpc public instance
resource "aws_instance" "requester-vpc-public-ec2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key
  associate_public_ip_address = true
  security_groups             = [aws_security_group.requester-vpc-ec2-sg.id]

  subnet_id = aws_subnet.requester-vpc-public-subnet-2b.id

  tags = {
    Name = "vpc-peering-requester-vpc-public-ec2"
  }

  connection {
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/.ssh/${var.key}.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "mkdir vpc-peering"
    ]
  }

  provisioner "file" {
    source      = "app/.dockerignore"
    destination = "/home/ec2-user/vpc-peering/.dockerignore"
  }

  provisioner "file" {
    source      = "app/Dockerfile"
    destination = "/home/ec2-user/vpc-peering/Dockerfile"
  }

  provisioner "file" {
    source      = "app/index.js"
    destination = "/home/ec2-user/vpc-peering/index.js"
  }

  provisioner "file" {
    source      = "app/package.json"
    destination = "/home/ec2-user/vpc-peering/package.json"
  }
}

# requester vpc private instance
resource "aws_instance" "requester-vpc-private-ec2" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key
  security_groups = [aws_security_group.requester-vpc-ec2-sg.id]

  subnet_id = aws_subnet.requester-vpc-private-subnet-2c.id

  tags = {
    Name = "vpc-peering-requester-vpc-private-ec2"
  }
}

# accepter vpc private instance
resource "aws_instance" "accepter-vpc-private-ec2" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key
  security_groups = [aws_security_group.accepter-vpc-ec2-sg.id]

  subnet_id = aws_subnet.accepter-vpc-private-subnet-2c.id

  tags = {
    Name = "vpc-peering-accepter-vpc-private-ec2"
  }
}
