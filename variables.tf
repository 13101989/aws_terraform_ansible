# Define AWS access key ID variable
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key ID"
}

# Define AWS secret access key variable
variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
}



variable "region" {
  description = "AWS region"
  type        = string
}



variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name_user_to_ansible" {
  description = "Name of the AWS key pair used for connecting to ansible instance"
  type        = string
}

variable "key_name_ansible_to_wordpress" {
  description = "Name of the AWS key pair used for connecting to wordpress instance"
  type        = string
}


variable "ssh_access_cidr" {
  description = "CIDR block for SSH access"
  type        = string
}

variable "web_access_cidr" {
  description = "CIDR block for web access"
  type        = string
}

