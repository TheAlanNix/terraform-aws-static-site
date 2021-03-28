resource "aws_acm_certificate" "default" {
  domain_name               = var.fqdn
  subject_alternative_names = var.aliases
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = aws_acm_certificate.default.arn

  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]

  depends_on = [aws_route53_record.validation]
}
