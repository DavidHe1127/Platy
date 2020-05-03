resource "aws_iam_instance_profile" "instance-profile" {
  name = "dockerzon-instance-profile"
  role = aws_iam_role.instance-profile-role.name
}

resource "aws_iam_role" "instance-profile-role" {
  name                  = "dockerzon-instance-profile-role"
  assume_role_policy    = file("configs/assumer_role.policy.json")
  force_detach_policies = true

  tags = {
    Purpose = "Allow ec2 to contact ecs"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "instance-profile-policy"
  description = "Dockerzon instance profile role policy"

  policy = file("configs/allow_create_log_group.policy.json")
}

resource "aws_iam_role_policy_attachment" "policy-attachment" {
  role       = aws_iam_role.instance-profile-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
