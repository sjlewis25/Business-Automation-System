output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
  description = "DNS of the Load Balancer"
}

output "rds_endpoint" {
  value = aws_db_instance.database.endpoint
  description = "RDS Endpoint"
}

output "web_server_1_public_ip" {
  value = aws_instance.web_server_1.public_ip
}

output "web_server_2_public_ip" {
  value = aws_instance.web_server_2.public_ip
}
