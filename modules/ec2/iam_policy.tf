data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "secretsmanager_read" {
  name        = "SecretsManagerReadAccess"
  description = "Allow EC2 to read database credentials from Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "arn:aws:secretsmanager:us-east-1:${data.aws_caller_identity.current.account_id}:secret:prod/db-credentials*"
      }
    ]
  })
}
