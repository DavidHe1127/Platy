resource "aws_instance" "pub-vpc-public-ec2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key
  associate_public_ip_address = true
  # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
  security_groups = [aws_security_group.pub-vpc-ec2-sg.id]
  # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

  subnet_id = aws_subnet.pub-vpc-public-subnet-2b.id

  tags = {
    Name = "vpc-peering-pub-vpc-public-ec2"
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
    source      = "app/"
    destination = "/home/ec2-user/vpc-peering"
  }

  # provisioner "file" {
  #   source      = "app/Dockerfile"
  #   destination = "/home/ec2-user/vpc-peering/"
  # }

  # provisioner "file" {
  #   source      = "app/index.js"
  #   destination = "/home/ec2-user/vpc-peering/"
  # }
}

# resource "aws_instance" "pub-vpc-private-ec2" {
#   ami                         = var.ami
#   instance_type               = "t2.micro"
#   key_name                    = var.key
#   # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
#   security_groups = [var.sg]
#   # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
#   # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

#   subnet_id = aws_subnet.pub-vpc-private-subnet-2c.id

#   tags = {
#     Name = "vpc-peering-pub-vpc-private-ec2"
#   }
# }

# resource "aws_instance" "pri-vpc-private-ec2" {
#   ami                         = var.ami
#   instance_type               = "t2.micro"
#   key_name                    = var.key
#   # user_data            = templatefile("ec2/register_instance.sh", { cluster = var.cluster })
#   security_groups = [var.sg]
#   # iam_instance_profile = aws_iam_instance_profile.instance-profile.name
#   # user_data            = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })

#   subnet_id = aws_subnet.pri-vpc-private-subnet-2c.id

#   tags = {
#     Name = "vpc-peering-pri-vpc-private-ec2"
#   }
# }

# # resource "aws_iam_instance_profile" "instance-profile" {
# #   name = "dockerzon-instance-profile"
# #   role = aws_iam_role.instance-profile-role.name
# # }

# # resource "aws_iam_role" "instance-profile-role" {
# #   name               = "dockerzon-instance-profile-role"
# #   assume_role_policy = file("ec2/assumer_role_policy.json")

# #   tags = {
# #     Purpose = "Allow ec2 to contact ecs"
# #   }
# # }

# # resource "aws_iam_policy_attachment" "ecs-ec2" {
# #   name       = "ecs-ec2"
# #   roles      = [aws_iam_role.instance-profile-role.name]
# #   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# # }
