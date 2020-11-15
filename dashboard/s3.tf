resource "aws_s3_bucket" "dashboard" {
  bucket = "dashboard.${var.domain_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "dashboard" {
  bucket = aws_s3_bucket.dashboard.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
              "AWS": "${aws_cloudfront_origin_access_identity.dashboard.iam_arn}"
              },
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::dashboard.${var.domain_name}/*"
            ]
        }
    ]
}
POLICY
}
