provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket = "dave-dockerzon-ecs-tfstate"
    key    = "dockerzon-datadog-terraform.tfstate"
    region = "ap-southeast-2"
    # alternatively create an IAM user and attach required permissions to him. The resulting policy can then be added
    # to ACL
    profile = "qq"
  }
}

variable "datadog_aws_integration_external_id" {
  # Get it from AWS integration tile, Role Delegation
  default     = "c0dd1f13549d4b2c8a69e488d39b5651"
  description = "Get it from AWS integration tile, Role Delegation"
}

data "aws_iam_policy_document" "datadog_aws_integration_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      # DD's account ID
      identifiers = ["arn:aws:iam::464622532012:root"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        var.datadog_aws_integration_external_id
      ]
    }
  }
}

data "aws_iam_policy_document" "datadog_aws_integration" {
  statement {
    actions = [
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "ec2:Describe*",
      "support:*",
      "tag:GetResources",
      "tag:GetTagKeys",
      "tag:GetTagValues",
      "ecs:Describe*",
      "ecs:List*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "datadog_aws_integration" {
  name   = "DatadogAWSIntegrationPolicy"
  policy = data.aws_iam_policy_document.datadog_aws_integration.json
}

resource "aws_iam_role" "datadog_aws_integration" {
  name               = "DatadogAWSIntegrationRole"
  description        = "Role for Datadog AWS Integration"
  assume_role_policy = data.aws_iam_policy_document.datadog_aws_integration_assume_role.json
}

resource "aws_iam_role_policy_attachment" "datadog_aws_integration" {
  role       = aws_iam_role.datadog_aws_integration.name
  policy_arn = aws_iam_policy.datadog_aws_integration.arn
}
