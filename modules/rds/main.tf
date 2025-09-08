resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "database" {
  identifier              = "smartops-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name

  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.sg_id]

  multi_az                = true
  backup_retention_period = 7
  deletion_protection     = false
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name        = "smartops-db"
    Environment = var.environment
  }
}


