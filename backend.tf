terraform {
  backend "s3" {
    bucket         = "business-automation-tf-state-123456"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
