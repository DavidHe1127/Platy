# requester vpc public instance
resource "aws_instance" "requester-vpc-public-ec2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key
  associate_public_ip_address = true
  # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
  security_groups = [aws_security_group.requester-vpc-ec2-sg.id]
  # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

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
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key
  # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
  security_groups = [aws_security_group.requester-vpc-ec2-sg.id]
  # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

  subnet_id = aws_subnet.requester-vpc-private-subnet-2c.id

  tags = {
    Name = "vpc-peering-requester-vpc-private-ec2"
  }
}

# accepter vpc private instance
resource "aws_instance" "accepter-vpc-private-ec2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key
  # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
  security_groups = [aws_security_group.accepter-vpc-ec2-sg.id]
  # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

  subnet_id = aws_subnet.accepter-vpc-private-subnet-2c.id

  tags = {
    Name = "vpc-peering-accepter-vpc-private-ec2"
  }
}

# resource "aws_iam_instance_profile" "instance-profile" {
#   name = "dockerzon-instance-profile"
#   role = aws_iam_role.instance-profile-role.name
# }

# resource "aws_iam_role" "instance-profile-role" {
#   name               = "dockerzon-instance-profile-role"
#   assume_role_policy = file("ec2/assumer_role_policy.json")

#   tags = {
#     Purpose = "Allow ec2 to contact ecs"
#   }
# }

# resource "aws_iam_policy_attachment" "ecs-ec2" {
#   name       = "ecs-ec2"
#   roles      = [aws_iam_role.instance-profile-role.name]
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }
