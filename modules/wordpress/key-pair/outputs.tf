output "ansible_to_wordpress_private_key" {
  value     = tls_private_key.ansible_to_wordpress_key.private_key_openssh
  sensitive = true
}

output "key_name" {
  description = "The ansible to wordpress public key pair name"
  value       = aws_key_pair.ansible_to_wordpress_public_key_pair.key_name
}