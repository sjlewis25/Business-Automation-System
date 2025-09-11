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

variable "environment" {
  description = "The environment name (dev, test, prod)"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "name" {
  description = "Name prefix for ASG and Launch Template"
  type        = string
  default     = "business-app"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "BusinessAutomationSystem"
  }
}

variable "budget_notification_email" {
  description = "Email address for cost alerts"
  type        = string
}


