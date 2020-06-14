# EC2 Instance Profile
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

resource "aws_iam_role_policy_attachment" "instance-profile-role-policy-attachment" {
  role       = aws_iam_role.instance-profile-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Task Execution Role
resource "aws_iam_role" "task-exec-role" {
  name                  = "dockerzon-task-exec-role"
  force_detach_policies = true

  tags = {
    Purpose = "Allow ecs task to access params on SSM"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TaskExecRole",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# use line below when using custom key to decrypt secret
# "arn:aws:kms:ap-southeast-2:${data.aws_caller_identity.current.account_id}:key/${data.aws_kms_key.ssm-aws-managed-kms}"
resource "aws_iam_policy" "task-exec-role-policy" {
  name        = "custom-task-exec-role-policy"
  description = "Policy to allow ecs task access params on SSM"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters"
      ],
      "Resource": [
        "arn:aws:ssm:ap-southeast-2:${data.aws_caller_identity.current.account_id}:parameter/dockerzon/weather-*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "custom-task-exec-role-policy-attachment" {
  role       = aws_iam_role.task-exec-role.name
  policy_arn = aws_iam_policy.task-exec-role-policy.arn
}

resource "aws_iam_role_policy_attachment" "predefined-task-exec-role-policy-attachment" {
  role       = aws_iam_role.task-exec-role.name
  policy_arn = data.aws_iam_policy.task-exec-role-policy-aws.arn
}

