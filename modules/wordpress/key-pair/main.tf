# Generate an ED25519 SSH key pair for Ansible
# This is used by Ansible node to connect to the wordpress node
resource "tls_private_key" "ansible_to_wordpress_key" {
  algorithm   = "ED25519"
  ecdsa_curve = "P521"
}

# Create an AWS key pair for connecting to wordpress node
resource "aws_key_pair" "ansible_to_wordpress_public_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.ansible_to_wordpress_key.public_key_openssh
}


