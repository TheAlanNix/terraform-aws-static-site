locals {
  route53_zone_id = var.use_existing_route53_zone ? data.aws_route53_zone.default[0].zone_id : aws_route53_zone.default[0].zone_id
}

data "aws_route53_zone" "default" {
  count = var.use_existing_route53_zone ? 1 : 0
  name  = var.fqdn
}

resource "aws_route53_zone" "default" {
  count = var.use_existing_route53_zone ? 0 : 1
  name  = var.fqdn
}

resource "aws_route53_record" "default" {
  zone_id = local.route53_zone_id
  name    = var.fqdn
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aliases" {
  count = length(var.aliases)

  zone_id = local.route53_zone_id
  name    = var.aliases[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "validation" {

  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = local.route53_zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = each.value.zone_id
  ttl             = 60
}
