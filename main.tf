provider "aws" {
  region = var.region
}

module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidr     = var.public_subnet_cidr
  public_subnet_2_cidr   = var.public_subnet_2_cidr
  private_subnet_1_cidr  = var.private_subnet_1_cidr
  private_subnet_2_cidr  = var.private_subnet_2_cidr
  availability_zones     = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "asg_app" {
  source              = "./modules/asg_app"
  name                = "business-app"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  security_group_id   = module.security_groups.web_sg_id
  subnet_ids          = module.vpc.public_subnet_ids
  target_group_arn    = module.alb.target_group_arn

  db_host             = module.rds.db_instance_endpoint
  db_user             = var.db_username
  db_password         = var.db_password
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  environment       = var.environment
}

module "rds" {
  source      = "./modules/rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  subnet_ids  = module.vpc.private_subnet_ids
  vpc_id      = module.vpc.vpc_id
  sg_id       = module.security_groups.rds_sg_id
  environment = var.environment
}


