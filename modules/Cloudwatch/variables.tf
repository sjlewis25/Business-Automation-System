variable "alb_name" {}
variable "rds_instance_id" {}
variable "environment" {}

variable "common_tags" {
  description = "Common tags for CloudWatch alarms"
  type        = map(string)
}
