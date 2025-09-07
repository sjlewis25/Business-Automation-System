variable "name" {}

variable "ami_id" {}

variable "instance_type" {}

variable "security_group_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {}

variable "min_size" {
  default = 1
}

variable "desired_capacity" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "db_host" {}

variable "db_user" {}

variable "db_password" {}
