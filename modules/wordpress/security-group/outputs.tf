output "security_group_name" {
  description = "The name of the wordpress security group"
  value       = aws_security_group.wordpress_security_group.name
}