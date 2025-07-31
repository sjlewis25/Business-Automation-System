provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zones = var.availability_zones
}

module "security_groups" {
  source      = "./modules/security_groups"
  vpc_id      = module.vpc.vpc_id
  my_ip       = var.my_ip
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_ids   = [module.security_groups.web_sg_id]
  user_data_template = "${path.module}/scripts/user_data.sh"
}

module "rds" {
  source               = "./modules/rds"
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  subnet_ids           = module.vpc.private_subnet_ids
  vpc_id               = module.vpc.vpc_id
  sg_id                = module.security_groups.rds_sg_id
}

