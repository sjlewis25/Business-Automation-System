resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
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
  skip_final_snapshot     = true
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.sg_id]
}
