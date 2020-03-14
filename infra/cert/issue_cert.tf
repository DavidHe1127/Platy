provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

resource "aws_acm_certificate" "ssl-cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    app = "dockerzon-ecs"
  }

  lifecycle {
    create_before_destroy = true
  }
}
