# Output the public DNS of the Ansible EC2 instance
output "ansible_public_ip" {
  value = aws_instance.aws_ec2_ansible.public_ip
}
