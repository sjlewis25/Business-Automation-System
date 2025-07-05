output "rds_endpoint" {
  value = aws_db_instance.database.endpoint
  description = "RDS Endpoint"
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
