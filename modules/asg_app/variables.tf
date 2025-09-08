variable "name" {}

variable "ami_id" {}

variable "instance_type" {}

variable "security_group_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {}

variable "min_size" {
  type    = number
  default = 1
}

variable "desired_capacity" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "db_host" {}

variable "db_user" {}

variable "db_password" {}


