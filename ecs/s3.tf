resource "aws_s3_bucket" "api_media_static" {
  bucket = "${var.tags["Name"]}-api-media-static"
  acl    = "private"

  tags = var.tags
}

# resource "aws_s3_bucket_policy" "api_media_static" {
#   bucket = aws_s3_bucket.api_media_static.id

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "Allow ECS EC2 Profile to access bucket",
#       "Effect": "Allow",
#       "Principal": "${aws_iam_role.ecs_instance_role.arn}",
#       "Action": "s3:*",
#       "Resource": "${aws_s3_bucket.api_media_static.bucket}/*",
#     }
#   ]
# }
# POLICY
# }
