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

# Attach AWS-managed SecretsManagerReadOnlyAccess policy
resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# Attach CloudWatch logging policy
resource "aws_iam_role_policy_attachment" "attach_cloudwatch_agent" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Create an instance profile for EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-secrets-instance-profile"
  role = aws_iam_role.ec2_secrets_role.name
}

