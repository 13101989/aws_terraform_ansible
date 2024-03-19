# Launch an EC2 instance for WordPress
resource "aws_instance" "aws_ec2_wordpress" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.security_groups

  tags = {
    Name = "WordPress-Instance"
  }
}