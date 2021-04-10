resource "random_id" "uniq" {
  byte_length = 4
}

#tfsec:ignore:AWS002 tfsec:ignore:AWS077
resource "aws_s3_bucket" "main" {
  bucket = "${var.fqdn}-www-${random_id.uniq.hex}"
  acl    = "private"
  policy = data.aws_iam_policy_document.bucket_policy.json

  website {
    index_document = var.index_document
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      "Name" = "${var.fqdn}-www-${random_id.uniq.hex}"
    },
  )
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
