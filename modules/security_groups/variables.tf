variable "vpc_id" {
  type = string
}

variable "my_ip" {
  description = "Your public IP address for SSH access"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all security group resources"
  type        = map(string)
}
