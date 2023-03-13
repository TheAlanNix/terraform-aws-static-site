output "s3_bucket_name" {
  value       = aws_s3_bucket.default.id
  description = "S3 Bucket Name"
}

output "cloudfront_distribution" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "CloudFront Distribution ID"
}
