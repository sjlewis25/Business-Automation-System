variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data_path" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs"
}
