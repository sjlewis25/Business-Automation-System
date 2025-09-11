variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  description = "Common tags for RDS resources"
  type        = map(string)
}
