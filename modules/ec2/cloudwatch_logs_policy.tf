resource "aws_iam_policy" "cloudwatch_logs" {
  name        = "EC2CloudWatchLogsPolicy"
  description = "Allows EC2 to send logs to CloudWatch Logs"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = "*"
      }
    ]
  })
}
