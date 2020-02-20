resource "aws_instance" "web" {
  ami                  = var.ami
  instance_type        = "t2.micro"
  key_name             = var.key_name
  user_data            = templatefile("ec2/bootstrap/index.sh", { cluster = var.cluster })
  security_groups      = [var.app_sg_id]
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name

  count     = var.instance_count
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = "${var.name}-0${count.index}"
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "dockerzon-instance-profile"
  role = aws_iam_role.instance-profile-role.name
}

resource "aws_iam_role" "instance-profile-role" {
  name               = "dockerzon-instance-profile-role"
  assume_role_policy = file("ec2/assumer_role.policy.json")

  tags = {
    Purpose = "Allow ec2 to contact ecs"
  }
}

resource "aws_iam_policy_attachment" "ecs-ec2" {
  name       = "ecs-ec2"
  roles      = [aws_iam_role.instance-profile-role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy" "allow-create-log-group" {
  name   = "test_policy"
  role   = aws_iam_role.instance-profile-role.id
  policy = file("ec2/allow_create_log_group.policy.json")
}
