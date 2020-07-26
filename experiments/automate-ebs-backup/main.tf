provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket = "dave-dockerzon-ecs-tfstate"
    key    = "dockerzon-automate-ebs-backup-terraform.tfstate"
    region = "ap-southeast-2"
    # alternatively create an IAM user and attach required permissions to him. The resulting policy can then be added
    # to ACL
    profile = "qq"
  }
}

data "aws_iam_policy_document" "dlm-assume-role-policy" {
  statement {
    sid     = "TrustedEntity"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dlm.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "dlm-role-policy-document" {
  statement {
    sid = "EC2RelatedPermissions"
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeVolumes",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "EC2SnapshotPermissions"
    actions = [
      "ec2:CreateTags"
    ]
    effect    = "Allow"
    resources = ["arn:aws:ec2:*::snapshot/*"]
  }
}

resource "aws_iam_policy" "dockerzon-dlm-role-policy" {
  name   = "dockerzon-dlm-role-policy"
  path   = "/dockerzon/"
  policy = data.aws_iam_policy_document.dlm-role-policy-document.json
}

resource "aws_iam_role" "dockerzon-dlm-role" {
  name               = "dockerzon-dlm-role"
  path               = "/dockerzon/"
  assume_role_policy = data.aws_iam_policy_document.dlm-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "dockerzon-dlm-role-policy" {
  role       = aws_iam_role.dockerzon-dlm-role.name
  policy_arn = aws_iam_policy.dockerzon-dlm-role-policy.arn
}

resource "aws_dlm_lifecycle_policy" "dlm-lifecycle-policy" {
  description        = "dlm test"
  execution_role_arn = aws_iam_role.dockerzon-dlm-role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "DailySnapshots"

      create_rule {
        interval      = 1
        interval_unit = "HOURS"
        # UTC time
        times         = ["11:15"]
      }

      retain_rule {
        count = 2
      }

      tags_to_add = {
        SnapshotCreator = "DataLifecycleManager"
      }

      copy_tags = false
    }

    target_tags = {
      Name = "dockerzon-vol"
    }
  }
}
