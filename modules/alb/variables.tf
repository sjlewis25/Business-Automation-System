variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  description = "Tags to apply to ALB resources"
  type        = map(string)
}
