provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket  = "dave-dockerzon-ecs-tfstate"
    key     = "dockerzon-ecs-cloudwatch-event-terraform.tfstate"
    region  = "ap-southeast-2"
    # alternatively create an IAM user and attach required permissions to him. The resulting policy can then be added
    # to ACL
    profile = "qq"
  }
}

resource "aws_sqs_queue" "log-group-created" {
  name                      = "LogGroupCreatedQueue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
}

resource "aws_cloudwatch_event_rule" "log-group-created" {
  name        = "log-group-added"
  description = "Capture events when log group is created"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.logs"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "log-group-created-target" {
  rule      = aws_cloudwatch_event_rule.log-group-created.name
  target_id = "log-group-created-target-sqs"
  arn       = aws_sqs_queue.log-group-created.arn
}

resource "aws_sqs_queue_policy" "log-group-created-target" {
  queue_url = aws_sqs_queue.log-group-created.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.log-group-created.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_rule.log-group-created.arn}"
        }
      }
    }
  ]
}
POLICY
}
