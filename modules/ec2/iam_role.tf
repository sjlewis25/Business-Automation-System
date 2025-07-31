resource "aws_iam_role" "ec2_secrets_role" {
  name = "ec2-secrets-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.secretsmanager_read.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-secrets-instance-profile"
  role = aws_iam_role.ec2_secrets_role.name
}
