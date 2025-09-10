output "db_instance_endpoint" {
  description = "RDS endpoint used by the app"
  value       = aws_db_instance.database.endpoint
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.database.db_name
}

output "db_instance_id" {
  description = "RDS instance ID for CloudWatch alarms"
  value       = aws_db_instance.database.id
}
