data "aws_ecr_repository" "api_app" {
  name = "scubadivedubai-api-app"
}

data "aws_ecr_repository" "api_nginx" {
  name = "scubadivedubai-api-nginx"
}

resource "aws_ecr_lifecycle_policy" "api_app" {
  repository = data.aws_ecr_repository.api_app.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "api_nginx" {
  repository = data.aws_ecr_repository.api_nginx.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
