# Launch an EC2 instance for Ansible
resource "aws_instance" "aws_ec2_ansible" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.security_groups

  user_data = file("${path.module}/install-ansible.sh")

  tags = {
    Name = "Ansible-Instance"
  }
}
