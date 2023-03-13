resource "random_id" "uniq" {
  byte_length = 4
}

#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "default" {
  bucket        = "${var.fqdn}-www-${random_id.uniq.hex}"
  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      "Name" = "${var.fqdn}-www-${random_id.uniq.hex}"
    },
  )
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.default.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {

  statement {
    sid       = "AllowOaiGetAccess"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.fqdn}-www-${random_id.uniq.hex}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }

  statement {
    sid       = "AllowOaiListAccess"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.fqdn}-www-${random_id.uniq.hex}"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.default.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "default" {
  bucket = aws_s3_bucket.default.id

  index_document {
    suffix = var.index_document
  }
}
