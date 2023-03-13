# static-site-terraform-module

![GitHub release](https://img.shields.io/github/v/release/thealannix/static-site-terraform-module?sort=semver)
![Terraform Tests](https://github.com/thealannix/static-site-terraform-module/actions/workflows/terraform-tests.yml/badge.svg)

A Terraform Module for building the infrastructure to host a static website. The following will be deployed:
- S3 Bucket
- CloudFront Distribution
- Route53 DNS
- TLS/SSL Certificate

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 4.0 |
| random | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 4.58.0 |
| random | 3.4.3 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_route53_record.aliases](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.allow_cloudfront_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | Additional domain aliases to add to the CloudFront distribution | `list(string)` | `[]` | no |
| cloudfront\_price\_class | The PriceClass for CloudFront distribution | `string` | `"PriceClass_100"` | no |
| force\_destroy | The force\_destroy argument of the S3 bucket | `bool` | `true` | no |
| fqdn | The primary FQDN of the website and also name of the S3 bucket | `string` | n/a | yes |
| index\_document | The HTML file to use as the index document | `string` | `"index.html"` | no |
| tags | A key/value map to use for tagging resources | `map(string)` | `{}` | no |
| use\_existing\_route53\_zone | A boolean representing whether to use an existing Route53 domain | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_distribution | CloudFront Distribution ID |
| s3\_bucket\_name | S3 Bucket Name |
<!-- END_TF_DOCS -->
