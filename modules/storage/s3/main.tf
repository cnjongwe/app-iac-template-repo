resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "demo" {
  bucket = aws_s3_bucket.demo.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "demo" {
  bucket = aws_s3_bucket.demo.id
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    expiration {
      days = var.lifecycle_days
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "SSE-S3"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_tagging" "demo" {
  bucket = aws_s3_bucket.demo.id

  tag_set = var.tags
}

resource "aws_s3_bucket_versioning" "demo" {
    bucket = aws_s3_bucket.demo.id
    versioning_configuration {
      status = var.versioning? "Enabled" : "Suspended"
    }
  
}

resource "aws_s3_bucket_notification" "demo" {
    count = var.create ? 1:0
    bucket = aws_s3_bucket.demo.id

    eventbridge = var.Enable_eventbridge



  }


resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.demo.id

  target_bucket = var.enable_logging
  target_prefix = var.bucket_prefix
}

resource "aws_s3_bucket_object_lock_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id
  count = var.enable_bucket.lock
}

resource "aws_s3_bucket_ownership_controls" "demo" {
    bucket = aws_s3_bucket.demo.id

    rule {
      object_ownership = "BucketOwnerEnforced"
  
}
}