variable "region" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}
variable "availability_zones" {
  type = list(string)
}

variable "ami_id" {}
variable "instance_type" {}
variable "my_ip" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
