
#---------------------------------------------------------------------------------------------------
# Bucket Policies
#---------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "state_force_ssl" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.state.arn,
      "${aws_s3_bucket.state.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

#---------------------------------------------------------------------------------------------------
# Buckets
#---------------------------------------------------------------------------------------------------
data "aws_region" "state" {
}

resource "aws_s3_bucket_policy" "state_force_ssl" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state_force_ssl.json
}


resource "aws_s3_bucket" "state" {
  bucket        = var.state_bucket_name
  acl           = "private"
  force_destroy = var.s3_bucket_force_destroy

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
