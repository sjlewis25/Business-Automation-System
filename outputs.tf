output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "web_server_public_ip" {
  value = module.ec2.public_ip
}
