provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone        = "us-east-1a"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.20.0/24"
  map_public_ip_on_launch = true
  availability_zone        = "us-east-1b"
}

# Create Security Group for Web Servers
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instances (Web Servers)
resource "aws_instance" "web_server_1" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "new-key"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "Hello, Terraform from Web Server 1!" > /var/www/html/index.html
              EOF
}

resource "aws_instance" "web_server_2" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "new-key"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "Hello, Terraform from Web Server 2!" > /var/www/html/index.html
              EOF
}

# Create Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

# Create Target Group
resource "aws_lb_target_group" "target_group" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
}

# Attach EC2 Instances to Target Group
resource "aws_lb_target_group_attachment" "attach_1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web_server_1.id
}

resource "aws_lb_target_group_attachment" "attach_2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web_server_2.id
}

# Create RDS Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

# Create RDS Database
resource "aws_db_instance" "database" {
  allocated_storage      = 20
  engine                = "mysql"
  engine_version        = "8.0.35"
  instance_class        = "db.t3.micro"
  username             = "admin"
  password             = "password123"
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  skip_final_snapshot  = true
}
