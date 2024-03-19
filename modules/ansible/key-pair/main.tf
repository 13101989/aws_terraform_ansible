# Create an AWS key pair for the EC2 user
# This is used by the user to connect to the Ansible node.
resource "tls_private_key" "user_to_ansible_key" {
  algorithm   = "ED25519"
  ecdsa_curve = "P521"
}

# Create an AWS key pair for EC2 user for connecting to Ansible node
resource "aws_key_pair" "user_to_ansible_public_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.user_to_ansible_key.public_key_openssh
}




