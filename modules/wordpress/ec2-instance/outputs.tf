# Output the public DNS of the Wordpress EC2 instance
output "wordpress_public_ip" {
  value = aws_instance.aws_ec2_wordpress.public_ip
}

output "availability_zone" {
  description = "Id of the wordpress instance"
  value       = aws_instance.aws_ec2_wordpress.availability_zone
}

output "instance_id" {
  description = "Availability zone of the wordpress instance"
  value       = aws_instance.aws_ec2_wordpress.id
}

