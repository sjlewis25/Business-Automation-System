resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data = file(abspath(var.user_data_template))
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "FlaskAppServer"
  }
}
