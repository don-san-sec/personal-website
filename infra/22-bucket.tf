resource "aws_s3_bucket" "pweb" {
  bucket = local.domain_name
}

resource "aws_s3_bucket_public_access_block" "pweb_block" {
  bucket = aws_s3_bucket.pweb.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "pweb_policy" {
  bucket = aws_s3_bucket.pweb.bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.pweb.id}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.pweb_block]
}


resource "aws_s3_bucket_website_configuration" "pweb_configuration" {
  bucket = aws_s3_bucket.pweb.bucket

  index_document {
    suffix = "index.html"
  }
}
