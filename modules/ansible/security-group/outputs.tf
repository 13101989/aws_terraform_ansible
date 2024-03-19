output "security_group_name" {
  description = "The name of the ansible security group"
  value       = aws_security_group.ansible_security_group.name
}