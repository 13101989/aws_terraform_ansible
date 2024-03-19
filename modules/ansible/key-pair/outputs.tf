output "user_to_ansible_private_key" {
  value     = tls_private_key.user_to_ansible_key.private_key_openssh
  sensitive = true
}

output "key_name" {
  description = "The user to ansible public key pair name"
  value       = aws_key_pair.user_to_ansible_public_key_pair.key_name
}