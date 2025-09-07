environment            = "dev"
region                 = "us-east-1"

vpc_cidr               = "10.0.0.0/16"
public_subnet_cidr     = "10.0.1.0/24"
public_subnet_2_cidr   = "10.0.4.0/24"
private_subnet_1_cidr  = "10.0.2.0/24"
private_subnet_2_cidr  = "10.0.3.0/24"
availability_zones     = ["us-east-1a", "us-east-1b"]

ami_id                 = "ami-0c02fb55956c7d316"  # Amazon Linux 2
instance_type          = "t2.micro"

db_name                = "mydb"

my_ip                  = "0.0.0.0/0"

module "asg_app" {
  source = "../../modules/asg_app"

  name              = "business-app"
  ami_id            = var.ami_id
  instance_type     = var.instance_type

  security_group_id = module.ec2_sg.security_group_id
  subnet_ids        = module.vpc.public_subnets
  target_group_arn  = module.alb.target_group_arn

  db_host     = module.rds.db_instance_endpoint
  db_user     = var.db_username
  db_password = var.db_password
}
