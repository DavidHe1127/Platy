provider "aws" {
  profile = "qq"
  region  = "ap-southeast-2"
}

data "aws_route53_zone" "zone" {
  name         = var.domain_fqdn
  private_zone = false
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

// create a CNAME record on route53
resource "aws_route53_record" "add-cname-record" {
  name    = aws_acm_certificate.ssl-cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.ssl-cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = [aws_acm_certificate.ssl-cert.domain_validation_options.0.resource_record_value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.ssl-cert.arn
  validation_record_fqdns = [aws_route53_record.add-cname-record.fqdn]
}

